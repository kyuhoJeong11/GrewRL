fr = open('/home/user/Documents/maml_rl/data/local/posticml-trpo-ant2-randleg-200/leg1.0_fbs1000_flr_0.1_mlr0.01/debug.log', 'rt')
fw = open('/home/user/Documents/maml_rl/data/local/posticml-trpo-ant2-randleg-200/leg1.0_fbs1000_flr_0.1_mlr0.01/progress.csv', 'wt')

comma = False
linebreak = False
for line in fr.readlines():
    s = line.split()
    if len(s) == 6:
        if s[4] == '----------------------':
            if linebreak == False:
                fw.write('\n')
                comma = False
                linebreak = True
        else:
            if comma:
                fw.write(',')
            fw.write(s[5])
            comma = True
            linebreak = False