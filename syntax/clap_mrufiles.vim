
syntax match ClapMRUFilename /\v\f*\/\zs[^\]]+\ze/ contained
syntax match ClapMRUFilename /\v\[@<=[^/]+\]@=/    contained
syntax match ClapMRUPath     /\f\+/                contains=ClapMRUFilename

hi default link ClapMRUPath              ClapFile
hi default link ClapMRUFilename          Directory
