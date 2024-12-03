binary_matrix_CLUSTER <- function(matrix_rows, matrix_columns) {
	# Import the package
	library(cluster)

	# Import the binary matrix generator
	source("Binary_matrix.R")

	# Generate a matrix of 0s and 1s
	bmatrix <- binary_matrix(matrix_rows, matrix_columns)

	# Generate a random sequence of rows that will be replaced
	sub_order <- sample(1:nrow(bmatrix), nrow(bmatrix), replace = FALSE)

	# Construct a (empty) vector to store the average Silhouette scores
	degrading_scores <- c()

	for (i in sub_order) {
		# Apply k-means with 2 clusters
		clustering <- kmeans(bmatrix, centers = 2)

		# Compute the Silhouette widths
		sil_widths <- silhouette(clustering$cluster, dist(bmatrix))

		# Compute the average Silhouette score
		sil_score <- mean(sil_widths[, 3])

		# Add the new value
		degrading_scores <- append(degrading_scores, sil_score)

		# Pick a random number between 0 and 1, rounded to two digits
		# for the sake of simplicity
		new_value <- round(runif(n = 1, min = 0, max = 1), digits = 2)

		# Substitute the old row with the new one
		bmatrix[i, ] <- rep(new_value, ncol(bmatrix))
	}

	return(degrading_scores)
}

sanity_check_good_CLUSTER <- function() {
	# Import the package
	library(cluster)

	# Import the sanity check dataset
	sc_dataset_good <- read.csv("sc_dataset_good.csv")

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering_good <- kmeans(sc_dataset_good, centers = 2)

	# Compute the Silhouette widths
	sil_widths_good <- silhouette(sc_clustering_good$cluster,
	                              dist(sc_dataset_good))

	return(sil_widths_good[, 3])
}

sanity_check_bad_CLUSTER <- function() {
	# Import the package
	library(cluster)

	# Import the sanity check dataset
	sc_dataset_bad <- read.csv("sc_dataset_bad.csv")

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering_bad <- kmeans(sc_dataset_bad, centers = 2)

	# Compute the Silhouette widths
	sil_widths_bad <- silhouette(sc_clustering_bad$cluster,
                                 dist(sc_dataset_bad))

	return(sil_widths_bad[, 3])
}
