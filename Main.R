#cat("Save to file? [Y/N] ")
#response <- readLines(file("stdin"), 1)
#
#if (response == "N") {
#	x11()
#}

for (i in c("cluster", "drclust", "tidyclust", "rguhi", "TDA", "optpart",
            "Kira", "didec")) {
	if (system.file(package = i) == "") {
		stop(c("Missing package: ", i))
		q()
	}
}

source("bin/Package_CLUSTER.R")
cat("Current package: cluster \n")

sc_scores <- sanity_check_good_CLUSTER()
sc_scores_bad <- sanity_check_bad_CLUSTER()
bm_scores <- binary_matrix_CLUSTER(8, 4)

pdf("cluster.pdf")
par(mfrow = c(1, 3))
plot(sc_scores, main = "Package: cluster (good sanity check)",
	 xlab = "i-th value", ylab = "Silhouette score for the i-th value",
	 xlim = c(0, 200), ylim = c(-1, 1), type = 'h')
plot(sc_scores_bad, main = "Package: cluster (bad sanity check)",
	 xlab = "i-th value", ylab = "Silhouette score for the i-th value",
	 xlim = c(0, 200), ylim = c(-1, 1), type = 'h')
plot(bm_scores, main = "Package: cluster (binary matrix)",
	 xlab = "iteration", type = 'b', pch = 21, cex = 1.5, bg = "black",
	 ylab = "Average Silhouette score for the i-th iteration")
dev.off()

# source("Package_DRCLUST.R")
# source("Package_TIDYCLUST.R")
# source("Package_RGUHI.R")
# source("Package_TDA.R")
# source("Package_OPTPART.R")
# source("Package_KIRA.R")
# source("Package_DIDEC.R")
