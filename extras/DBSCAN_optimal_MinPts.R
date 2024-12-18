library(dbscan)
dataset_filenames <- list.files(path = "../data", pattern = "^[a-r|t-z|0-9]")

pdf("../doc/DBSCAN_optimal_MinPts.pdf")

for (filename in dataset_filenames) {
	dataset <- read.csv(paste0("../data/", filename))
	dataset <- na.omit(dataset)
	m <- 2 * ncol(dataset)
	kNNdistplot(dataset, minPts = m)
	legend("top", legend = c(filename))
}

dev.off()
