# Import the MASS and ggplot2 library
library(MASS)
library(ggplot2)

# GOOD DATASET

# Generate two datapoints with a bivariate normal distribution
normal_A <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(-5, 5))
normal_B <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(5, -5))

# Merge the two together in one dataset
dataset <- rbind(normal_A, normal_B)

# Coerce into a dataframe
sc_dataset_good <- as.data.frame(dataset)
colnames(sc_dataset_good) <- c("X", "Y")

# Write to output file
write.csv(sc_dataset_good, "../data/sc_dataset_good.csv", row.names = FALSE)

# Dump the plot of the dataset
ggplot(data = sc_dataset_good, mapping = aes(x = X, y = Y)) +
geom_point() +
labs(title = "Sanity check good dataset", x = "X", y = "Y")

ggsave(filename = "sc_dataset_good.pdf", path = "../doc")

# BAD DATASET

# Generate a datapoint with a bivariate normal distribution

normal_C <- mvrnorm(n = 200, Sigma = matrix(c(10, 5, 5, 10),
                    nrow = 2, ncol = 2), mu = c(0, 0))

# Coerce into a dataframe
sc_dataset_bad <- as.data.frame(normal_C)
colnames(sc_dataset_bad) <- c("X", "Y")

# Write to output file
write.csv(sc_dataset_bad, "../data/sc_dataset_bad.csv", row.names = FALSE)

# Dump the plot of the dataset
ggplot(data = sc_dataset_bad, mapping = aes(x = X, y = Y)) +
geom_point() +
labs(title = "Sanity check bad dataset", x = "X", y = "Y")

ggsave(filename = "sc_dataset_bad.pdf", path = "../doc")
