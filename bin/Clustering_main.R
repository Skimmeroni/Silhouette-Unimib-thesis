main <- function(clustering_methods, dataset_filenames) {
	for (filename in dataset_filenames) {
		cat("Current dataset:", filename, "\n")
		dataset <- read.csv(paste0("data/", filename))
		dataset <- na.omit(dataset)

		result <- paste0("results/results_", filename, ".pdf")
		pdf(result)

		rnk_combinations <- data.frame(sil_avg = numeric(),
		                               parameters = character())

		rnk_by_method <- data.frame(sil_avg = numeric(),
		                            method = character())

		for (method in clustering_methods) {
			# Load the functions specific for the clustering algorithm in use
			file <- paste0("bin/Clustering_", method, ".R")
			source(file)

			# Load the dataset and test some combinations of hyperparameters
			hyp_combinations <- tune_hyperparameters(dataset)

			# Extract the hyperparameter combination that maximizes Silhouette
			opt_set <- extract_opt_hyperparameters(hyp_combinations)

			# Apply clustering with such hyperparameter combination
			opt_dataframe <- create_clustering_dataframe(dataset, opt_set)

			# Plot regarding hyperparameters
			hyp_plot <- hyperparameter_plot(hyp_combinations, filename)
			print(hyp_plot)

			# Generic plot with cluster size (same for all algorithms)
			generic_plot <- create_generic_plot(opt_dataframe, opt_set, filename, method)
			print(generic_plot)

			# Alternative plot, not using Silhouette (different for each
			# algorithm). May or may not exist
			custom_plot <- customized_plot(dataset, filename)
			if (!is.null(custom_plot)) {
				print(custom_plot)
			}

			# Merge results for ranking
			rnk_this <- format_for_ranking(hyp_combinations)
			rnk_this$method <- method
			rnk_combinations <- rbind(rnk_combinations, rnk_this)

			by_method_this <- data.frame(sil_avg = max(rnk_this$sil_avg), method = method)
			rnk_by_method <- rbind(rnk_by_method, by_method_this)
		}

		rnk_combinations <- rnk_combinations[order(rnk_combinations$sil_avg, decreasing = TRUE), ]
		row.names(rnk_combinations) <- NULL
		rnk_combinations <- head(rnk_combinations, 15)
		rnk_plot <- create_ranking_plot(rnk_combinations, filename)
		print(rnk_plot)

		by_method_plot <- create_ranking_by_method_plot(rnk_by_method, filename)
		print(by_method_plot)

		dev.off()
	}
}

extract_opt_hyperparameters <- function(hyperparameters) {
	optimal_by_num <- which.max(hyperparameters$sil_avg)
	optimal_set <- hyperparameters[optimal_by_num, ]
	optimal_set <- subset(optimal_set, select = -sil_avg)
	optimal_set <- as.vector(optimal_set)
	return(optimal_set)
}

create_generic_plot <- function(dataframe, optimal_hyps, dataset, method) {
	tostring <- paste(names(optimal_hyps), optimal_hyps,
	                  sep = " = ", collapse = ", ")

	P <- ggplot(data = dataframe, aes(Cluster, y = after_stat(count) /
		                                           sum(after_stat(count)))) +
		 geom_bar(aes(fill = Cluster)) +
		 theme(legend.position = "top") +
		 ylim(0, 1) +
		 labs(title = paste0("Dataset: ", dataset),
		      subtitle = paste0("Clustering: ", method,
		                        "\nParameters used: ", tostring),
		      y = "Cluster size (normalized to [0, 1])",
		      x = "Cluster number")

	return(P)
}

format_for_ranking <- function(hyps) {
	ranking_combinations <- data.frame(sil_avg = hyps[, ncol(hyps)], parameters = " ")

	if (ncol(hyps) == 2) {
		ranking_combinations$parameters <- paste0(colnames(hyps)[1], " = ", hyps[, 1])
	} else {
		ranking_combinations$parameters <- apply(hyps[, -ncol(hyps)], 1,
	                                             function(row) {
	                                                  paste0(names(hyps)[-ncol(hyps)],
	                                                         " = ", row, collapse = "\n")
	                                             })
	}

	return(ranking_combinations)
}

create_ranking_plot <- function(ranking_combinations, filename) {
	P <- ggplot(data = ranking_combinations, mapping = aes(x = sil_avg, y = parameters, fill = method)) +
		 geom_col() +
		 xlim(-1, 1) +
		 labs(title = paste0("Dataset: ", filename),
		      subtitle = "Hyperparameter combinations ranked by its average Silhouette score",
		      x = "Silhouette score",
		      y = "")

	return(P)
}

create_ranking_by_method_plot <- function(ranking_by_method, filename) {
	P <- ggplot(data = ranking_by_method, mapping = aes(x = method, y = sil_avg)) +
		 geom_col(fill = "purple") +
		 ylim(-1, 1) +
		 labs(title = paste0("Dataset: ", filename),
		      subtitle = "Algorithms ranked by their average Silhouette score",
		      x = "Algorithm",
		      y = "Silhouette score")

	return(P)
}
