args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1) {
	stop(c("Wrong number of arguments given: expected 1, got ", length(args)))
}

all_packages <- c("cluster", "drclust", "tidyclust", "Kira", "reticulate")
#clustering_methods <- c("KMEANS", "HIERARCHICAL-CLUSTERING", "DBSCAN",
#                        "BIRCH", "MEAN-SHIFT", "HDBSCAN")
clustering_methods <- c("KMEANS", "DBSCAN")
dataset_filenames <- list.files(path = "data", pattern = "^[a-r|t-z|0-9]")

# Load ggplot2 here, since it will be used anyway
library(ggplot2)

# Extract the argument
what_to_do <- args[1]
if (what_to_do == "--silhouette") {
	for (package in all_packages) {
		if (system.file(package = package) == "") {
			stop(c("Missing package: ", package))
		}
	}

	source("bin/Silhouette_main.R")

	main(all_packages)
} else if (what_to_do == "--clustering") {
	source("bin/Clustering_main.R")
	library(cluster)

	main(clustering_methods, dataset_filenames)
} else {
	stop(c("Unknown argument: ", what_to_do,
	       "\nSupported arguments: --silhouette, --clustering"))
}

# ????????
for (i in list.files(pattern = "Rplots*")) {
	file.remove(i)
}
