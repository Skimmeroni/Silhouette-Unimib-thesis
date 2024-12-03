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

sanity_check_CLUSTER <- function() {
	# Import the package
	library(cluster)

	# Import the sanity check dataset generator
	source("Sanity_check.R")

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering <- kmeans(sc_dataset(), centers = 2)

	# Compute the Silhouette widths
	sil_widths <- silhouette(sc_clustering$cluster, dist(sc_dataset()))

	return(sil_widths[, 3])
}
