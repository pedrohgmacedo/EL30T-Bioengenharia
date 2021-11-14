function J=limited_regiongrowing(I,x,y,x1,x2,y1,y2,reg_maxdist)
limited_region = I(x1:x2, y1:y2);
new_coord_x = x - x1;
new_coord_y = y - y1;

limited_J = regiongrowing(I,new_coord_x,new_coord_y,reg_maxdist) 
s1 = ones(x1,y);
s2 = ones(x2-x1,y-y1);
s3 = ones(x-x2,y-y2);
s4 = ones(x2-x1, y1);

J = [    s1
      s4 J s2
         s3  ]

end