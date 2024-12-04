binary_matrix <- function(matrix_rows, matrix_columns) {
	# Construct a vector of 0s and a vector of 1s and bind them together
	A <- rep(0, (matrix_rows * matrix_columns) / 2)
	B <- rep(1, (matrix_rows * matrix_columns) / 2)
	binary_vector <- c(A, B)

	# Coerce the vector into a matrix
	test_matrix <- matrix(binary_vector, nrow = matrix_rows,
                          ncol = matrix_columns, byrow = TRUE)

	return(test_matrix)
}
