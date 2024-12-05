sanity_check <- function(package_name, dataset_path) {
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	# Import the sanity check dataset
	sc_dataset <- read.csv(dataset_path)

	# Compute the Silhouette widths
	sil_widths <- compute_si_Silhouette(sc_dataset)
	return(sil_widths)
}
