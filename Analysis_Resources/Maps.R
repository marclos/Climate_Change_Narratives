plot_usmap(regions = "counties") + 
  labs(title = "US Counties",
       subtitle = "This is a blank map of the counties of the United States.") + 
  theme(panel.background = element_rect(color = "black", fill = "lightblue"))


plot_usmap(include = c("CA", "ID", "NV", "OR", "WA")) +
  labs(title = "Western US States",
       subtitle = "These are the states in the Pacific Timezone.")

plot_usmap(data = statepop, values = "pop_2015", color = "red") + 
  scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
  theme(legend.position = "right")

plot_usmap(
  data = statepop, values = "pop_2015", include = c("CA", "ID", "NV", "OR", "WA"), color = "red"
) + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Population (2015)", label = scales::comma
  ) + 
  labs(title = "Western US States", subtitle = "These are the states in the Pacific Timezone.") +
  theme(legend.position = "right")


# Lat/Lon of Sioux Falls, SD
test_data <- data.frame(lon = -96.70, lat = 43.55)

transformed_data <- usmap_transform(test_data)

plot_usmap("states") + 
  geom_point(data = transformed_data, 
             aes(x = x, y = y), 
             color = "red",
             size = 3)