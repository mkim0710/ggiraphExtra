#'Draw an interactive area plot
#'
#'@param data A data.frame
#'@param mapping Set of aesthetic mappings created by aes or aes_.
#'@param palette A character string indicating the color palette
#'@param reverse If true, reverse palette colors
#'@param alpha Transparency
#'@param size Line size
#'@param use.label Logical. Whether or not use column label in case of labelled data
#'@param use.labels Logical. Whether or not use value labels in case of labelled data
#'@return An area plot
#'@importFrom ggplot2 geom_area
#'@export
#'@examples
#'require(gcookbook)
#'require(ggplot2)
#'ggArea(uspopage,aes(x=Year,y=Thousands,fill=AgeGroup))
ggArea=function(data,mapping,palette="Blues",reverse=TRUE,alpha=0.4,size=0.3,use.label=TRUE,use.labels=TRUE){

        # data=uspopage;mapping=aes(x=Year,y=Thousands,fill=AgeGroup)
        fillvar<-xvar<-yvar<-NULL
        name=names(mapping)
        xlabels<-ylabels<-filllabels<-colourlabels<-xlab<-ylab<-colourlab<-filllab<-NULL
        for(i in 1:length(name)){
                (varname=paste0(name[i],"var"))
                labname=paste0(name[i],"lab")
                labelsname=paste0(name[i],"labels")
                assign(varname,paste(mapping[[name[i]]]))
                x=eval(parse(text=paste0("data$",eval(parse(text=varname)))))
                assign(labname,attr(x,"label"))
                assign(labelsname,get_labels(x))
        }
        direction=ifelse(reverse,-1,1)
        p<-ggplot(data,aes_string(x=xvar,y=yvar,fill=fillvar))+
                geom_area(alpha=alpha)+
                geom_line(position="stack",size=size)+
                scale_fill_brewer(palette=palette,direction=direction)
        if(use.labels) {
                if(!is.null(xlabels)) p<-p+scale_x_continuous(breaks=1:length(xlabels),labels=xlabels)
                if(!is.null(ylabels))  p<-p+scale_y_continuous(breaks=1:length(ylabels),labels=ylabels)
                if(!is.null(filllabels)) p=p+scale_fill_brewer(palette=palette,direction=direction,
                                                               labels=filllabels)
                if(!is.null(colourlabels)) p=p+scale_color_discrete(labels=colourlabels)
                #p+scale_color_continuous(labels=colourlabels)
        }
        if(use.label){
                if(!is.null(xlab)) p<-p+labs(x=xlab)
                if(!is.null(ylab)) p<-p+labs(y=ylab)
                if(!is.null(colourlab)) p<-p+labs(colour=colourlab)
                if(!is.null(filllab)) p<-p+labs(fill=filllab)
        }
        p

}

