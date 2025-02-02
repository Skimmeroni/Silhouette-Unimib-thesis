main <- function(silhouette_packages) {
	for (package in silhouette_packages) {
		# Load functions needed for the current package
		cat("Current package:", package, "\n")
		file <- paste0("bin/Package_", toupper(package), ".R")
		source(file)

		result <- paste0("results/results_", toupper(package), ".pdf")
		pdf(result)

		# Load sanity check dataset (favorable case)
		start_time <- Sys.time()
		sc_dataset_good <- read.csv("data/sc_dataset_good.csv")

		# Compute average Silhouette score and clustering
		sc_score_good <- round(compute_avg_Silhouette(sc_dataset_good),
		                       digits = 5)
		sc_dataframe_good <- create_plottable_df(sc_dataset_good)
		finish_time <- round(Sys.time() - start_time, digits = 2)

		# Plot the result
		sc_plot_good <- sanity_check_plot("sc_dataset_good.csv",
		                                  sc_dataframe_good, package,
		                                  sc_score_good, finish_time)
		print(sc_plot_good)

		# Load sanity check dataset (unfavorable case)
		start_time <- Sys.time()
		sc_dataset_bad <- read.csv("data/sc_dataset_bad.csv")

		# Compute average Silhouette score and clustering
		sc_score_bad <- round(compute_avg_Silhouette(sc_dataset_bad),
		                      digits = 5)
		sc_dataframe_bad <- create_plottable_df(sc_dataset_bad)
		finish_time <- round(Sys.time() - start_time, digits = 2)

		# Plot the result
		sc_plot_bad <- sanity_check_plot("sc_dataset_bad.csv",
		                                 sc_dataframe_bad, package,
		                                 sc_score_bad, finish_time)
		print(sc_plot_bad)

		# Compute the Silhouette scores for binary matrix
		start_time <- Sys.time()
		bm_scores <- avg_sil_scores_for_bm(20, 10, package)
		finish_time <- round(Sys.time() - start_time, digits = 2)

		# Plot the result
		bm_plot <- binary_matrix_plot(bm_scores, package, finish_time)
		print(bm_plot)

		dev.off()
	}

	# Chosen package was 'cluster'
	pdf("results/Final_comparison.pdf")
	fc_plot1 <- final_comparison_plot_for_bm(20, 10)
	print(fc_plot1)
	fc_plot2 <- final_comparison_plot_for_bm(100, 50)
	print(fc_plot2)
	fc_plot3 <- final_comparison_plot_for_bm(1000, 500)
	print(fc_plot3)
	dev.off()
}

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
		new_value <- round(runif(n = 1, min = 0, max = 1), digits = 5)

		# Substitute the old row with the new one
		bmatrix[i, ] <- rep(new_value, ncol(bmatrix))
	}

	# Construct a dataframe with Silhouette scores as y values
	bm_dataframe <- data.frame(X = 1:nrow(bmatrix), Y = vector_of_scores)

	return(bm_dataframe)
}

sanity_check_plot <- function(dataset, dataframe, package_name, score, time) {
	P <- ggplot(data = dataframe, mapping = aes(x = X, y = Y,
	                                            color = Cluster)) +
	     scale_color_manual(values = c("blue", "green")) +
	     geom_point() +
	     labs(title = paste0("Sanity check for package: ", package_name),
	          subtitle = paste0("Using dataset: ", dataset,
	                            "\nAverage Silhouette score: ", score,
	                            "\nCompleted in: ", time, " seconds"),
	          x = "X", y = "Y")

	return(P)
}

binary_matrix_plot <- function(score_vector, package_name, time) {
	P <- ggplot(data = score_vector, mapping = aes(x = X, y = Y)) +
	     ylim(-1, 1) +
	     scale_color_manual(values = c("blue", "green")) +
	     geom_point() +
	     geom_smooth(formula = y ~ x, method = "lm") +
	     labs(title = paste0("Binary matrix for package: ", package_name),
	          subtitle = paste0("Completed in: ", time, " seconds"),
	          y = "Average Silhouette score for the i-th iteration",
	          x = "Iteration")

	return(P)
}

final_comparison_plot_for_bm <- function(matrix_rows, matrix_columns) {
	source("bin/Package_CLUSTER.R")
	test_scores <- avg_sil_scores_for_bm(matrix_rows, matrix_columns, "CLUSTER")
	test_scores$Implementation <- "cluster"
	source("bin/Package_RETICULATE.R")
	compare_scores <- avg_sil_scores_for_bm(matrix_rows, matrix_columns, "RETICULATE")
	compare_scores$Implementation <- "scikit-learn"
	all_scores <- rbind(test_scores, compare_scores)

	P <- ggplot(data = all_scores, mapping = aes(x = X, y = Y, color = Implementation)) +
	     ylim(-1, 1) +
	     geom_point() +
	     scale_color_manual(values = c("blue", "green")) +
	     labs(title = "Binary matrix comparison between 'cluster' (R) and 'scikit-learn' (Python)",
	          subtitle = paste0("Matrix size: ", matrix_rows, " rows, ", matrix_columns, " columns"),
		  y = "Average Silhouette score for the i-th iteration",
	          x = "Iteration")

	return(P)
}
