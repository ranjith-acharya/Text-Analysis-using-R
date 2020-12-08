install.packages('tm')
library(tm)

docs<- Corpus(DirSource('data'))
inspect(docs)

writeLines(as.character(docs[30]))

toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, " ", x))})

docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, ":")
docs <- tm_map(docs, toSpace, "'")
docs <- tm_map(docs, toSpace, "'")
docs <- tm_map(docs, toSpace, " -")

writeLines(as.character(docs[30]))

docs <- tm_map(docs, removePunctuation)

docs <- tm_map(docs, content_transformer(tolower))

docs <- tm_map(docs, removeNumbers)

docs <- tm_map(docs, removeWords, stopwords("english"))

docs <- tm_map(docs, stripWhitespace)

writeLines(as.character(docs[30]))

install.packages('SnowballC')
library(SnowballC)

docs <- tm_map(docs, stemDocument)

writeLines(as.character(docs[30]))

dtm <- DocumentTermMatrix(docs)

freq <- colSums(as.matrix(dtm))

length(freq)

ord <- order(freq, decreasing = TRUE)

freq[head(ord)]

freq[tail(ord)]

dtmr <- DocumentTermMatrix(docs, control=list(wordLengths=c(4, 20), bounds = list(global = c(3, 27))))

install.packages("wordcloud")
library(wordcloud)

set.seed(42)

wordcloud(names(freq), freq, min.freq=70)

wordcloud(names(freq), freq, min.freq=70, colors=brewer.pal(6, "Dark2"))