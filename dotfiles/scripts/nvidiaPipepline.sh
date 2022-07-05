#!/usr/bin/env bash
nvidia-settings --assign CurrentMetaMode="DP-2: nvidia-auto-select +0+240 {rotation=right, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-1: nvidia-auto-select +3000+1080 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-5: nvidia-auto-select +1080+1080 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
