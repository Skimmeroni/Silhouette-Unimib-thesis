#cat("Save to file? [Y/N] ")
#response <- readLines(file("stdin"), 1)
#
#if (response == "N") {
#	x11()
#}

packages <- c("cluster", "drclust", "tidyclust", "rguhi", "TDA", "optpart",
              "Kira", "didec")

for (i in packages) {
	if (system.file(package = i) == "") {
		stop(c("Missing package: ", i))
		q()
	}
}

source("bin/Package_CLUSTER.R")
source("bin/Plotting_facility.R")
cat("Current package: cluster \n")

sc_scores_good <- sanity_check_good_CLUSTER()
sc_scores_bad <- sanity_check_bad_CLUSTER()
bm_scores <- binary_matrix_CLUSTER(8, 4)
plot_results("cluster")

# source("Package_DRCLUST.R")
# source("Package_TIDYCLUST.R")
# source("Package_RGUHI.R")
# source("Package_TDA.R")
# source("Package_OPTPART.R")
# source("Package_KIRA.R")
# source("Package_DIDEC.R")
