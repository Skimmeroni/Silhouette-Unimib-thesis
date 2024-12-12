binary_matrix <- function(matrix_rows, matrix_columns, package_name) {
	file <- paste0("bin/Package_", toupper(package_name), ".R")
	source(file)

	# Construct a matrix of 0s and 1s
	A <- matrix(0, nrow = (matrix_rows / 2), ncol = matrix_columns)
	B <- matrix(1, nrow = (matrix_rows / 2), ncol = matrix_columns)
	bmatrix <- rbind(A, B)

	# Set the seed to reduce variability
	set.seed(11)

	# Generate a random sequence of rows that will be replaced
	sub_order <- sample(1:nrow(bmatrix), nrow(bmatrix), replace = FALSE)

	# Construct a (empty) vector to store the average Silhouette scores
	degrading_scores <- c()

	for (i in sub_order) {
		# Compute the average Silhouette score
		sil_score <- compute_avg_Silhouette(bmatrix)

		# Add the new value
		degrading_scores <- append(degrading_scores, sil_score)

		# Pick a random number between 0 and 1, rounded to two digits
		# for the sake of simplicity
		new_value <- round(runif(n = 1, min = 0, max = 1), digits = 2)

		# Substitute the old row with the new one
		bmatrix[i, ] <- rep(new_value, ncol(bmatrix))
	}

	bm_dataframe <- data.frame(var1 = 1:nrow(bmatrix), var2 = degrading_scores)
	colnames(bm_dataframe) = c("X", "Y")

	return(bm_dataframe)
}
