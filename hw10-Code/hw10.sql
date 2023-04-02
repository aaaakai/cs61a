.read hw10_data.sql

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes WHERE min < height AND height <= max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child AS name FROM parents, dogs WHERE parent = name ORDER BY -height;


-- Sentences about siblings that are the same size
CREATE TABLE siblings AS
  SELECT parents_a.child AS name, parents_b.child AS sib, sizes_a.size AS size FROM 
  parents AS parents_a, parents AS parents_b,
  dogs AS dogs_a, dogs AS dogs_b, sizes AS sizes_a, sizes AS sizes_b WHERE 
  parents_a.parent = parents_b.parent AND parents_a.child < parents_b.child AND 
  parents_a.child = dogs_a.name AND parents_b.child = dogs_b.name AND
  sizes_a.min < dogs_a.height AND dogs_a.height <= sizes_a.max AND
  sizes_b.min < dogs_b.height AND dogs_b.height <= sizes_b.max AND
  sizes_a.size = sizes_b.size;

CREATE TABLE sentences AS
  SELECT "The two siblings, " || name || " plus " || sib || " have the same size: " || 
  size FROM siblings;
