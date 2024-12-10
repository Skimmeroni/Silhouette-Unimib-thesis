compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(drclust)

	# Apply k-means on the dataset, with 2 centroids
	clustering <- dpcakm(matrix, 2, 1)

	# Compute the Silhouette
	sil_result <- silhouette(matrix, clustering)

	sil_result <- sil_result$cl.silhouette

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}

create_plottable_df <- function(dataset_path) {
	# Import the package
	library(drclust)

	dataframe <- read.csv(dataset_path)

	matrix <- as.matrix(dataframe)

	# Apply k-means on the dataset, with 2 centroids
	clustering_result <- dpcakm(matrix, 2, 1)

	# Extract clusters
	clusters <- clustering_result$U + 1
	clusters <- clusters[, 1]

	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) = c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))
	return(plottable_dataframe)
}
