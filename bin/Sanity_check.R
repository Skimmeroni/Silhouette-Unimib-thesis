sanity_check <- function(package_name, dataset_path) {
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	# Import the sanity check dataset
	sc_dataset <- read.csv(dataset_path)

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering <- kmeans(sc_dataset, centers = 2)

	sil_widths <- compute_si_Silhouette(sc_clustering, sc_dataset)
	return(sil_widths)
}
