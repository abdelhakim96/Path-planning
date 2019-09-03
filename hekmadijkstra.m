clear all
clc

y=[2 3 2 4 4 3 1 2 1];
x=[ 0 1 2 3 4 6 5 4 6 6 8 6 7 9 7 8 ; 0 2 3 2 4 4 3 1 2 1 5 5 6 1 2 4 ];
x(1,1)=0;
x(2,1)=3;
x(1,17)=9;
x(2,17)=3.5;
p=1;
c=0;
% vertices of obstacles 
n=17; % number of nodes
np=3; % number of polygons
pgon1 = polyshape([1 2 3 ],[2 3 2]);
plot(pgon1)
hold on
pgon2 = polyshape([4 6 5],[4 4 3]);
plot(pgon2)
hold on
pgon3 = polyshape([4 6 6],[1 2 1]);
plot(pgon3)
hold on
pgon4=polyshape([8 6 7],[5 5 6]);
hold on
plot(pgon4)
pgon5=polyshape([9 7 8],[1 2 4]);
hold on
plot(pgon5)
count=1;
k=0;
V=0;
cn=1;
count=1;
ss=1;
for i =1:n
    for j=1:n
        c=0;
        for p=1:5
         cx= (x(1,3*p-1)+x(1,3*p)+x(1,3*p+1))/3;
         cy= (x(2,3*p-1)+x(2,3*p)+x(2,3*p+1))/3;
         minx=min([x(1,j) x(1,i)]);
         miny=min([x(2,j) x(2,i)]);
         maxx=max([x(1,j) x(1,i)]);
         maxy=max([x(2,j) x(2,i)]);
         if (cx<=maxx && cx>=minx) || (cy<=maxy && cy>= miny)
         
         if ((x(2,j)-x(2,i))*x(1,3*p-1)-(x(1,j)-x(1,i))*x(2,3*p-1)-x(1,i)*x(2,j)+x(1,j)*x(2,i))>0
                            if ((x(2,j)-x(2,i))*x(1,3*p)-(x(1,j)-x(1,i))*x(2,3*p)-x(1,i)*x(2,j)+x(1,j)*x(2,i))<0 || ((x(2,j)-x(2,i))*x(1,3*p+1)-(x(1,j)-x(1,i))*x(2,3*p+1)-x(1,i)*x(2,j)+x(1,j)*x(2,i))<0
           
                                
                                c=1;
                            end
         else
               if  ((x(2,j)-x(2,i))*x(1,3*p-1)-(x(1,j)-x(1,i))*x(2,3*p-1)-x(1,i)*x(2,j)+x(1,j)*x(2,i))==0
                                if (((x(2,j)-x(2,i))*x(1,3*p+1)-(x(1,j)-x(1,i))*x(2,3*p+1)-x(1,i)*x(2,j)+x(1,j)*x(2,i))*((x(2,j)-x(2,i))*x(1,3*p)-(x(1,j)-x(1,i))*x(2,3*p)-x(1,i)*x(2,j)+x(1,j)*x(2,i)))<0
                                    c=1;
                                end
                            else
                                if ((x(2,j)-x(2,i))*x(1,3*p)-(x(1,j)-x(1,i))*x(2,3*p)-x(1,i)*x(2,j)+x(1,j)*x(2,i))>0 || ((x(2,j)-x(2,i))*x(1,3*p+1)-(x(1,j)-x(1,i))*x(2,3*p+1)-x(1,i)*x(2,j)+x(1,j)*x(2,i))>0
                                c=1;
                                end
               end
         end
        end
        end
      
        
        
        if c==0  
            k=k+1;
              G(1,i)=i;
              if i~=j && j
              G(k+1,i)=j;
           
                   %   plot ([x(1,i) x(1,j)],[x(2,i) x(2,j)])
                      hold on
              
              end
            
        end
        
    end
    k=0;
end


    path(1,1)=1;
    path(2,1)=0;
    angle(1)=0;
    for q = 2:n
        path(1,q)=q;
        path(2,q)=inf;
        angle(q)=0;
    end
    cnl=0;
    for h=1:n
        cnl(h)=cn;
        Gn=nonzeros(G(:,cn));
        l=length(Gn);
        dist=0;
        for m=2:l
        
        dist(1,1)=cn;
        dist(2,1)=path(2,cn);
        dist(1,m)=Gn(m);
        dist(2,m)=((x(2,Gn(m))-x(2,cn))^2 +((x(1,Gn(m))-x(1,cn))^2))^0.5+path(2,cn);
        
        if dist(2,m)<path(2,Gn(m))
        path(2,(Gn(m)))=dist(2,m);
        
        connect(1,ss)=cn ;
        connect(2,ss)=Gn(m);
        angle((Gn(m)))= atan((x(2,Gn(m))-x(2,cn))/(x(1,Gn(m)))-x(1,cn));
        ss=ss+1;
        end
        end
        paths = sortrows(path',2);
        paths=paths';
        f=2;
        while 1
         if h < 16
         Lia = ismember(paths(1,f),cnl);
         if Lia==1  
            f=f+1;
          else
        cn=paths(1,f); 
        break
         end
         else
             break
         end
        end
    end   
       labels = {' 1',' 2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17'};
       
       scatter(x(1,:),x(2,:))
text(x(1,:),x(2,:),labels,'VerticalAlignment','bottom','HorizontalAlignment','right')
       
    % labels = {'1','2','3','4','5','6','7','8','9','10'};
              
        
       t=1;
       w=1;
      while 1  
         
       if t==1
           if connect(2,length(connect)-w+1)==n
              rm(t)=connect(2,length(connect)-w+1);
              rm(t+1)=connect(1,length(connect)-w+1);
              t=t+1;
              
           end
             w=w+1;
       end
       if t~=1
     
         if  connect(2,length(connect)-w-t+2)==rm(length(rm))
                 rm(length(rm)+1)=connect(1,length(connect)-w-t+2);
           
         end
         t=t+1;
         if rm(length(rm))==1
             break
         end
       end
      end
       
      for uu=1:length(rm)-1
      plot ([x(1,rm(uu)) x(1,rm(uu+1))],[x(2,rm(uu)) x(2,rm(uu+1))])
      hold on
      end
      
           
       
       
       
        
        
        
        
    
        
        

                      

        
            
     
  

