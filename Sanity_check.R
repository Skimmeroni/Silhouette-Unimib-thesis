# Import the MASS library
library(MASS)

# Generate two datapoints with a bivariate normal distribution
normal_A <- mvrnorm(n = 100, mu = c(-5, 5),
                    Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2))
normal_B <- mvrnorm(n = 100, mu = c(5, -5),
                    Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2))

# Merge the two together in one dataset
dataset <- rbind(normal_A, normal_B)

# Coerce into a dataframe
sc_dataset <- as.data.frame(dataset)
colnames(sc_dataset) <- c("X", "Y")

# Write to output file
write.csv(sc_dataset, "sc_dataset.csv", row.names = FALSE)

# Dump the plot of the dataset
pdf("sc_dataset.pdf")
plot(sc_dataset, main = "Sanity check dataset", xlab = "X", type = 'p',
     pch = 21, cex = 1.5, ylab = "Y")
dev.off()
