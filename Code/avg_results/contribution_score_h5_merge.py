#!/usr/bin/env python
# coding: utf-8

import numpy as np
import pandas as pd
import deepdish as dd
import io
import h5py

directory = '/ix/djishnu/Aaron_F/Cleaned_Proteomics_Aaron/20240906/chrombpnet/Results/predictions_contribs'

#create arrays of all the contribution score h5s for each fold for counts and profile respectively
counts_h5_all = []
profile_h5_all = []
for i in range(0,5):
    c = dd.io.load((directory + '/fold{s}_contribs/fold{s}.counts_scores.h5').format(s = str(i)))
    p = dd.io.load((directory + '/fold{s}_contribs/fold{s}.profile_scores.h5').format(s = str(i)))
    counts_h5_all.append(c)
    profile_h5_all.append(p)

def create_combined(arr_folds, savename):
    shap = combine_simple(arr_folds, 'shap')
    pshap = combine_simple(counts_h5_all, 'projected_shap')
    raw = combine_simple(counts_h5_all, 'raw')
    combined = {'projected_shap':{'seq':pshap}, 'shap':{'seq':shap}, 'raw':{'seq':raw}}
    if savename != False:
        dd.io.save(savename, combined)
    return combined

def combine_simple(arr_folds, keyword):
    shaps = []
    for fold in arr_folds:
        shap = fold[keyword]['seq']
        shaps.append(shap)
    sum = shaps[0]
    for i in range(1, len(shaps)):
        sum = sum + shaps[i]
    average = sum/len(shaps)
    return average

def save_dict_to_h5(group, dictionary):
    for key, value in dictionary.items():
        if isinstance(value, dict):
            subgroup = group.create_group(key)
            save_dict_to_h5(subgroup, value)
        else:
            group.create_dataset(key, data=value)


#combine the counts contribution scores
counts_combined = create_combined(counts_h5_all, False)

with h5py.File('merged_count_scores.h5', 'w') as h5file:
    save_dict_to_h5(h5file, counts_combined)

#combine the profile contribution scores
profile_combined = create_combined(profile_h5_all, False)

with h5py.File('merged_profile_scores.h5', 'w') as h5file:
    save_dict_to_h5(h5file, profile_combined)
