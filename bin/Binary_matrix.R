binary_matrix <- function(matrix_rows, matrix_columns, package_name) {
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	# Construct a vector of 0s and a vector of 1s and bind them together
	A <- rep(0, (matrix_rows * matrix_columns) / 2)
	B <- rep(1, (matrix_rows * matrix_columns) / 2)
	binary_vector <- c(A, B)

	# Coerce the vector into a matrix
	bmatrix <- matrix(binary_vector, nrow = matrix_rows,
                      ncol = matrix_columns, byrow = TRUE)

	# Generate a random sequence of rows that will be replaced
	sub_order <- sample(1:nrow(bmatrix), nrow(bmatrix), replace = FALSE)

	# Construct a (empty) vector to store the average Silhouette scores
	degrading_scores <- c()

	for (i in sub_order) {
		# Apply k-means with 2 clusters
		clustering <- kmeans(bmatrix, centers = 2)

		# Compute the average Silhouette score
		sil_score <- compute_avg_Silhouette(clustering, bmatrix)

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
