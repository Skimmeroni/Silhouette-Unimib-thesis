library(dbscan, warn.conflicts = FALSE)
library(ggplot2)
source("../bin/Clustering_DBSCAN.R")
dataset_filenames <- list.files(path = "../data", pattern = "^[a-r|t-z|0-9]")
parameters <- read.csv("../data/s_DBSCAN.csv")
pdf("../results/DBSCAN_visual_comparison.pdf")

for (name in dataset_filenames) {
	cat("Current dataset:", name, "\n")
	dataframe <- read.csv(paste0("../data/", name))
	dataframe <- na.omit(dataframe)

	visual_opt_set <- as.vector(subset(parameters, filename == name))
	visual_opt_set <- c(visual_opt_set[2], visual_opt_set[3])

	visual_dataframe <- create_clustering_dataframe(dataframe, visual_opt_set)
	visual_string <- paste(names(visual_opt_set), visual_opt_set,
                               sep = " = ", collapse = ", ")

	palette <- c("#3d85c6", "#6fa8dc", "#9fc5e8", "#c27ba0", "#a64d79")

	P <- ggplot(data = visual_dataframe,
	            aes(Cluster, y = after_stat(count) / sum(after_stat(count)))) +
	     scale_fill_manual(values = palette) +
	     geom_bar(aes(fill = Cluster)) +
	     theme(legend.position = "top") +
	     ylim(0, 1) +
	     labs(title = paste0("Dataset: ", name),
	          subtitle = paste0("DBSCAN clustering with visual inspection",
	                            "\nParameters used: ", visual_string),
	          y = "Cluster size (normalized to [0, 1])",
	          x = "Cluster number")

	print(P)
}

dev.off()
