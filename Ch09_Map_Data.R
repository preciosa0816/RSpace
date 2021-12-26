##CH09_Map & Data
library(ggmap)

#(1)
#https://cloud.google.com/maps-platform/terms/
register_google(key='AIzaSyCAp7KOwiKGK-7c-kWdtq_fawwIcVsdlco')
gc<-geocode(enc2utf8("vancouver"))
gc
cen<-as.numeric(gc)
cen
map<-get_googlemap(center=cen,zoom=15)
ggmap(map)


#(2)
gc<-geocode(enc2utf8("설악산"))
gc
cen<-as.numeric(gc)
cen
map<-get_googlemap(center=cen,
                   zoom = 12,
                   size = c(640,640),
                   maptype = "roadmap"
                   )
ggmap(map)

#(3) 경도와 위도값을 입력해서 지도보기
cen<-c(-118.233248,34.08015)
cen
map<-get_googlemap(center=cen,
                   zoom = 9,
                   size = c(640,640),
                   maptype = "roadmap"
)
ggmap(map)

#(4) 지도의 중심점에 마커
gc<-geocode(enc2utf8("설악산"))
gc
cen<-as.numeric(gc)
cen
map<-get_googlemap(center=cen,
                   zoom = 10,
                   size = c(640,640),
                   maptype = "roadmap",
                   markers = gc
)
ggmap(map)

#(5) 지도의 여러 지점에 마커와 텍스트표시
names<-c("용두암","성산일출봉","정방폭포")
addr<-c("제주시 용두암길 15","서귀포시 성산읍 성산리", "서귀포시 동홍동 299-3")
gc<-geocode(enc2utf8(addr))
df<-data.frame(name=names,lon=gc$lon,lat=gc$lat)
df
cen<-c(mean(df$lon),mean(df$lat))
cen
map<-get_googlemap(center=cen,
                   zoom = 10,
                   size = c(640,640),
                   maptype = "roadmap",
                   markers = gc
)
ggmap(map)

gmap<-ggmap(map)
gmap+geom_text(data = df,
               aes(x=lon,y=lat),
               size=5,
               label=df$name
               )

####연습문제
library(ggmap)

#(1)
#https://cloud.google.com/maps-platform/terms/
register_google(key='AIzaSyCAp7KOwiKGK-7c-kWdtq_fawwIcVsdlco')
names<-c("도담삼봉/석문","구담/옥순봉","사인암","하선암","중선암","삼선암")
addr<-c("매포읍 삼봉로 644-33","단성면 월악로 3827", "대강면 사인암길 37","단성면 선암계곡로 1337","단성면 선암계곡로 868-2","단성면 선암계곡로 790")
gc<-geocode(enc2utf8(addr))
df<-data.frame(name=names,lon=gc$lon,lat=gc$lat)
df
cen<-c(mean(df$lon),mean(df$lat))
cen
map<-get_googlemap(center=cen,
                   zoom = 11,
                   size = c(640,640),
                   maptype = "roadmap",
                   markers = gc
)
ggmap(map)

gmap<-ggmap(map)
gmap+geom_text(data = df,
               aes(x=lon,y=lat),
               size=5,
               label=df$name
)
















