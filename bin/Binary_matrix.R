avg_sil_scores_for_bm <- function(matrix_rows, matrix_columns, package_name) {
	# Construct a matrix of 0s and 1s
	bmatrix <- matrix(rep(c(0, 1), each = matrix_rows / 2),
	                  nrow = matrix_rows, ncol = matrix_columns)

	# Set the seed to reduce variability
	set.seed(11)

	# Generate a random sequence of rows that will be replaced
	sub_order <- sample(1:nrow(bmatrix), nrow(bmatrix), replace = FALSE)

	# Construct a (empty) vector to store the average Silhouette scores
	vector_of_scores <- c()

	for (i in sub_order) {
		# Compute the average Silhouette score
		sil_score <- compute_avg_Silhouette(as.data.frame(bmatrix))

		# Add the new value
		vector_of_scores <- append(vector_of_scores, sil_score)

		# Pick a random number between 0 and 1, rounded to two digits
		# for the sake of simplicity
		new_value <- round(runif(n = 1, min = 0, max = 1), digits = 2)

		# Substitute the old row with the new one
		bmatrix[i, ] <- rep(new_value, ncol(bmatrix))
	}

	# Construct a dataframe with Silhouette scores as y values
	bm_dataframe <- data.frame(X = 1:nrow(bmatrix), Y = vector_of_scores)

	return(bm_dataframe)
}
