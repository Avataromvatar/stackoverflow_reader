# stackoverflow_reader

| View layer        | AppLayer           | Service Layer  |
| ------------- |:-------------:| -----:|
| TagList:      | AppTagService: | RestApi: |
| nextTagPage->      | nextTagPage->getRequest 1->      |   getRequest 1-> |
| updateTagList<- |<-updateTagList<-1 getResponse      |    <-1 getResponse |
|   |     |     |
