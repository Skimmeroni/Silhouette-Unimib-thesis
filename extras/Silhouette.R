# Load library containing Silhouette and plots
library(cluster)
library(ggplot2)

# Load flowers dataset (builtin)
data(iris)

# Last feature is not numeric
iris <- iris[, -5]

# Compute K-Means with K = 3
clustering_result <- kmeans(iris, 3)

# Compute s(i) for all elements
S <- silhouette(clustering_result$cluster, dist(iris))

# Prepare for plotting
S <- as.data.frame(S)
S$n <- seq(1, 150)
S <- transform(S, cluster = as.character(cluster))

# Plot s(i) widths
pdf("../doc/si.pdf")
P <- ggplot(data = S, mapping = aes(y = sil_width, x = n, fill = cluster)) +
     labs(title = "Plot dei valori di s(i) per il dataset Iris",
          x = "i-esimo elemento", y = "s(i)") + geom_col() + ylim(-1, 1) 
print(P)
dev.off()

S <- S[, -4]
S <- transform(S, cluster = as.numeric(cluster))
write.csv(S[seq(1, 10), ], "../data/siOne.csv")
write.csv(S[seq(50, 60), ], "../data/siTwo.csv")
write.csv(S[seq(100, 110), ], "../data/siThree.csv")
