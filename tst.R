data(penguins)
penguins$body_mass_kg = penguins$body_mass / 1000
summary(penguins[, c("body_mass_kg", "species")])

library(ggplot2)
ggplot(penguins, mapping = aes(x = body_mass_kg)) +
  geom_histogram(binwidth = 0.2) +
  facet_wrap(~species)


We can look at the many lines that `add_epred_draws()`:

```{r plot multiple regression lines}
#| code-fold: true
library(dplyr)
ggplot(
  data = posterior_lines |>
    group_by(sex, species) |>
    filter(.draw %in% sample(unique(.draw), 100)) |>
    ungroup(),
  mapping = aes(x = bm_kg_ctr + bm_kg_mean, y = .epred, color = sex) # group removed from here
) +
  geom_line(
    aes(group = interaction(.draw, sex)), # group specified only for this layer
    alpha = 0.05
  ) +
  geom_point(
    data = penguins,
    aes(x = bm_kg_ctr + bm_kg_mean, y = bill_len, color = sex),
    alpha = 0.5,
    size = 1
  ) +
  facet_wrap(~species) +
  labs(
    title = "Male penguins have slightly longer bills than females",
    x = "Body Mass (kg)",
    y = "Bill Length (mm)",
    color = "Sex"
  ) +
  theme_bw() +
  theme(legend.position = "bottom")
```

![](images/reg-lines-bill-len.png){#fig-bill-reg1 fig-align="center" width=600}

ggsave("images/.png", plot = tst, width = , height = , scale = 1)

[![Three histograms show penguin weights](./images/peng-hist.png){#fig-peng-hist fig-align="center" width=400}](./images/peng-hist.png)