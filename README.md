# Public Transport Stop Finder

This project identifies the *k* closest public transportation stops to a given location within the United States. It allows users to input a latitude and longitude, specify the number of nearest stops to find, and set a maximum search radius. The application returns nearby transit stop information.

## Features

- Accepts coordinates as input and returns the closest *k* transit stop locations within a maximum distance.
- Groups multiple stops that share the same location under a single result.
- Compares the performance of Quicksort and Heapsort for sorting transit locations by distance.
- Efficient nearest-neighbor lookup using a KDTree data structure.
- Web-based UI that allows interactive queries and visual feedback via map rendering.

## Environment

- see branch `no-merge/devcontainer` for instructions on using the vscode devcontainer

## Building

- do `nim data` to download data files
- do `nim test` to run the test programs
- do `nim cli` to build the command line interface. Outputs to cli dir.

## *Note on Repository History*

*This repository was created after we realized we needed to extend the course-provided template. Originally, we used a separate Git repository for development. Although this is a new repo, all group members have contributed their original work from the previous repository here, and credit for all contributions is fully preserved.*
