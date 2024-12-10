compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(cluster)

	# Apply k-means with 2 clusters
	kmeans_result <- kmeans(matrix, centers = 2)

	# Extract the clustering result
	clustering <- kmeans_result$cluster

	# Compute the Silhouette widths
	sil_result <- silhouette(clustering, dist(matrix))

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}

create_plottable_df <- function(dataset_path) {
	# Import the package
	library(cluster)

	dataframe <- read.csv(dataset_path)

	matrix <- as.matrix(dataframe)

	# Apply k-means with 2 clusters
	kmeans_result <- kmeans(matrix, centers = 2)

	# Extract the clustering result
	clusters <- kmeans_result$cluster

	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) = c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))
	return(plottable_dataframe)
}
