Encoding.default_external = 'UTF-8'

EMAIL_REGEXP = /([a-z0-9._-]+@[a-z0-9._-]+\.[a-z0-9._-]+)|[^a-z+]dot[^a-z+]com[^a-z+]/i
EMAIL_FORMAT_REGEXP = /^(([a-z0-9]([\-a-z0-9_\.]{0,1}[a-z0-9])*)@([a-z0-9]([-a-z0-9]*[a-z0-9])\.)+((a[cdefgilmnoqrstuwxz]|aero|arpa)|(b[abdefghijmnorstvwyz]|biz)|(c[acdfghiklmnorsuvxyz]|cat|com|coop|co\.uk)|d[ejkmoz]|(e[ceghrstu]|edu)|f[ijkmor]|(g[abdefghilmnpqrstuwy]|gov)|h[kmnrtu]|(i[delmnoqrst]|info|int)|(j[emop]|jobs)|k[eghimnprwyz]|l[abcikrstuvy]|(m[acdghklmnopqrstuvwxyz]|mil|mobi|museum)|(n[acefgilopruz]|name|net)|(om|org)|(p[aefghklmnrstwy]|pro)|qa|r[eouw]|s[abcdeghijklmnortvyz]|(t[cdfghjklmnoprtvwz]|travel)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw]))?$/
