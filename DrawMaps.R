library("leaflet")
library("rgdal")
library("RColorBrewer")
library("maptools")



colourCount = length(unique(team2004_geodata$CNTR_CODE))
getPalette = colorRampPalette(brewer.pal(8, "Greens"))

pal1 = getPalette(colourCount)
pal <- colorFactor(
  topo.colors(24),
  domain = team2004_geodata$CNTR_CODE)

bins <- c(-3, -2.5, -2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2, 2.5,Inf)
pal2 <- colorBin(topo.colors(24), domain = team2004_geodata$REF, bins = bins)


labels <- sprintf(
  "<strong>%s</strong><br/>Difference from average increase: %g ",
  team2004_geodata$CNTR_CODE, team2004_geodata$REF
) %>% lapply(htmltools::HTML)


m2 <- leaflet(team2004_geodata) %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor =  ~pal2(team2004_geodata$REF),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>% 
  addLegend(pal = pal2, values = ~REF, opacity = 0.7, title = NULL,
            position = "bottomright")
m2


