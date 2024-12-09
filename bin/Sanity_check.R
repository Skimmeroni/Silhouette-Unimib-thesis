sanity_check <- function(package_name, dataset_path) {
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	# Import the sanity check dataset
	sc_dataset <- read.csv(dataset_path)

	# Coerce the dataframe into a matrix
	sc_matrix <- as.matrix(sc_dataset)

	# Compute the Silhouette widths
	avg_sil_score <- compute_avg_Silhouette(sc_matrix)
	return(avg_sil_score)
}
