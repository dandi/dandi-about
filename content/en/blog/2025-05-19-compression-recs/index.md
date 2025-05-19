---
title: NWB Compression Recommendations for DANDI Archive
author: Ben Dichter
description: >
    An analysis of HDF5 and Zarr compression options for NWB files submitted to the DANDI Archive, providing recommendations based on file size, read speed, and write speed.
tags: [ "nwb", "compression", "hdf5", "zarr", "dandi", "best-practices" ]
date: 2025-05-19
---

When submitting large datasets to the DANDI Archive, it's crucial to consider data compression options that can substantially reduce file sizes. Smaller files reduce the storage burden on the DANDI Archive and make datasets more convenient to download for users. Neurodata Without Borders (NWB) now supports two file format backends: HDF5 and Zarr. Both formats have built-in capabilities for chunking and compression that can break large datasets into smaller pieces and apply lossless compression to each chunk. This approach reduces file size without altering the dataset values, and in some cases can even improve read or write speeds compared to uncompressed binary data.

DANDI recommends compressing large datasets, but the variety of algorithms and settings available can be overwhelming for NWB users unfamiliar with data engineering. This post aims to answer several common questions:

- By how much can the volume of my data be reduced?
- What compression options are available and how can I access them?
- Which compression algorithms and settings are optimal for my use case?

The answers depend on specific use cases, but our analysis provides general guidelines to help you make informed decisions based on three key metrics: file size, read speed, and write speed. You may also need to consider accessibility - whether the HDF5 or Zarr library can read your file out of the box or requires installation of a dynamic filter.

## Our Testing Approach

We conducted a comprehensive evaluation of several popular compression algorithms in HDF5 using the [h5plugin](http://www.silx.org/doc/hdf5plugin/latest/) library, which simplifies the installation process for various compression algorithms and makes them available to [h5py](https://docs.h5py.org/en/stable/index.html). For Python users, we highly recommend this package.

For our test data, we used action potential recordings from a Neuropixel probe (SpikeGLX acquisition system) from [DANDI:000053](https://dandiarchive.org/dandiset/000053/0.210819.0345), consisting of high-pass voltage data prior to spike-sorting. This represents a common use case for NWB files. While this analysis focuses on HDF5, similar compression principles apply to Zarr backends as well. We relied on h5py to automatically determine chunk shapes, with shuffle turned off.

## Results and Recommendations

![Compression algorithm comparison](./eval_compressions.png)
*Figure 1: Comparison of compression algorithms. The black circle shows data that is chunked but not compressed. Each color represents a different algorithm, with lightness/darkness indicating compression level.*

### Key Findings:

1.  **Best Overall Performance: zstd level 4**
    - Provides excellent compression ratio (about 45% reduction)
    - Maintains good read and write speeds at moderate compression levels
    - At higher levels, write time increases dramatically with minimal additional space savings

2.  **Fastest Read Performance: blosc lz4**
    - If optimizing primarily for read speed, blosc lz4 is 1.25x faster than zstd
    - For blosc lz4, level 4 offers a good balance between size and speed

3.  **Alternative Option: gzip**
    - Most accessible because it is built into HDF5 (no additional configuration needed)
    - Read time is about 1.8x slower than zstd
    - At moderate levels (e.g., the default level 4), offers similar file size and write time to zstd
    - Good option for users unable to configure custom dynamic filters

4.  **Best Compression Ratio: blosc zstd**
    - Achieves slightly better compression ratio and slightly worse read time than standard zstd
    - Significantly longer write times at higher compression levels

## Conclusion

By applying appropriate compression settings to your NWB files before uploading to DANDI, you can significantly reduce storage requirements and improve download experiences for users of your datasets. For most neurophysiology datasets using the HDF5 backend, we recommend zstd level 4 as a good default that balances compression ratio with performance. However, if you have specific requirements for read speed or file size, you might consider blosc lz4 or blosc zstd respectively.

While this analysis focused on HDF5, Zarr offers similar compression options and benefits. Zarr natively supports blosc, zstd, and gzip compression algorithms with comparable performance characteristics. This is an active area of research, and there are newer algorithms that are designed specifically for electrophysiology and available in Zarr. See [Compression strategies for large-scale electrophysiology data](https://iopscience.iop.org/article/10.1088/1741-2552/acf5a4) for a detailed discussion of these algorithms.

Remember that optimal compression settings may vary depending on your specific data characteristics and usage patterns. We encourage you to experiment with different options using the provided code example to find the best configuration for your datasets.


## Code

```python
import os
import hdf5plugin
import h5py
import time
from tqdm import tqdm
import matplotlib.pyplot as plt
import json
import pandas as pd
import seaborn as sns


def test_filter(run_name, **kwargs):
    """Get write time, read time, and file size for a run."""

    fname = f"{run_name}.h5"


    with h5py.File(fname, mode="w") as file:
        start = time.time()
        file.create_dataset(**kwargs)
        write_time = time.time() - start

    file_size = os.stat(fname).st_size

    with h5py.File(fname, mode="r") as file:
        start = time.time()
        data = file['data'][:]
        read_time = time.time() - start

    return dict(
        name=run_name,
        write_time=write_time,
        file_size=file_size,
        read_time=read_time,
    )

def create_mini_palette(color, filter_, compression_opts_list):
    """Create palette of different shades of the same color for a given filter."""

    mini_pallete = sns.light_palette(
    color=color,
    n_colors=len(compression_opts_list)+2)[2:]
    for comp_opts, this_color in zip(compression_opts_list, mini_pallete):
        palette.update({f"{filter_} {comp_opts}": this_color})
    return palette

fpath = "data/sub-npJ1_ses-20190521_behavior+ecephys.nwb"

file = h5py.File(fpath, 'r')

data = file['acquisition/ElectricalSeries/data'][:1000000]
print(f"{data.nbytes / 1e9} GB")

# set up parameters for tests
filters = {
    'no_filter': dict(
        filter_class={'chunks':True},
        compression_opts_list=[None],
    ),
    'zstd': dict(
        filter_class=hdf5plugin.Zstd(),
        compression_opts_list=[
            (0,),
            (3,),
            (6,),
            (9,),

        ],
    ),
    'lz4': dict(
        filter_class=hdf5plugin.LZ4(),
        compression_opts_list=[
            (0,),
            (1e3,),
            (1e6,),
        ],
    ),
    'gzip': dict(
        filter_class=dict(compression='gzip'),
        compression_opts_list=[
            1, 4, 9
        ]
    ),
    'lzf': dict(
        filter_class=dict(compression='lzf'),
        compression_opts_list=[None,],
    )
}


blosc_filters = ["blosclz", "lz4", "lz4hc", "zlib", "zstd"]

results = []




## run filters

#test non-blosc filters
for filter_name, filter_dict in tqdm(list(filters.items()), desc='non-blosc'):
    args = dict(
        name="data",
        data=data,
        **filter_dict["filter_class"]
    )
    for compression_opts in filter_dict["compression_opts_list"]:
        args.update(compression_opts=compression_opts)
        run_name = f"{filter_name} {compression_opts}"
        results.append(test_filter(run_name, **args))

# test blosc filters
for filter_name in tqdm(blosc_filters, desc='blosc'):
    for level in range(2, 9):
        args=dict(
            name="data",
            data=data,
            **hdf5plugin.Blosc(cname=filter_name, clevel=level, shuffle=0)
        )
        run_name = f"blosc {filter_name} {level}"
        results.append(test_filter(run_name, **args))

# dump results
with open('results.json', 'w') as file:
    json.dump(results, file)


df = pd.DataFrame(results)

# visualization - construct palette

# for non-blosc
counter = 0
base_palette = sns.color_palette(n_colors=11)
palette = {'no_filter None': 'k'}
for filter_, filter_dict in list(filters.items())[1:]:
    color = base_palette[counter]
    if filter_ not in ('no_filter None',):
        palette.update(create_mini_palette(color, filter_, filter_dict["compression_opts_list"]))
    counter += 1


# for blosc
for filter_name in blosc_filters:
    counter += 1
    color = base_palette[counter]
    palette.update(create_mini_palette(color, "blosc " + filter_name, range(2,9)))

n_filters = sum(len(x["compression_opts_list"]) for x in filters.values())
n_blosc_filters = 7*len(blosc_filters)
markers = ['o'] * n_filters + ['X'] * n_blosc_filters

sns.pairplot(data=df, hue="name", palette=palette, markers=markers, size=4, corner=True, diag_kind=None)

plt.savefig("eval_compressions.pdf", bbox_inches="tight")
```
