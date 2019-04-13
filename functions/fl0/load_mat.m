function M = load_mat(filename)
    

  temp = load(filename);
  
  M.VERT = [temp.surface.X, temp.surface.Y, temp.surface.Z];
  M.TRIV = temp.surface.TRIV;
  M.m = size(M.TRIV,1);
  M.n = size(M.VERT,1);

end