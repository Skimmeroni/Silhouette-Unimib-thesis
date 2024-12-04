sanity_check_good <- function(package_name) {
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	# Import the sanity check dataset
	sc_dataset_good <- read.csv("data/sc_dataset_good.csv")

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering_good <- kmeans(sc_dataset_good, centers = 2)

	sil_widths_good <- compute_si_Silhouette(sc_clustering_good,
                                             sc_dataset_good)
	return(sil_widths_good)
}

sanity_check_bad <- function(package_name) {
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	# Import the sanity check dataset
	sc_dataset_bad <- read.csv("data/sc_dataset_bad.csv")

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering_bad <- kmeans(sc_dataset_bad, centers = 2)

	sil_widths_bad <- compute_si_Silhouette(sc_clustering_bad,
                                             sc_dataset_bad)
	return(sil_widths_bad)
}
