# Tesla Dashcam Merge

Simple script to merge Tesla dashcam videos to easily view them in a merged file.

![overview](https://github.com/akiyamasho/tesla-dashcam-merge/assets/35907066/d295dfce-39fc-4230-8072-73a2dbe7c868)

Currently tested on MacOS Sonoma 14.4.1.

### Usage

1. Copy your dashcam videos from the Tesla USB drive.
   
2. Simply `cd` into a folder for a certain date inside either `SavedClips` or directly `cd` into `RecentClips` / `SentryClips`.

```
# Sample
cd ./SavedClips/2024-04-27_09-24-05
```

3. You can copy the `tesla-dashcam-merge.sh` script inside, or better yet, put it into a folder under your `$PATH`.

4. Run the script:
    - **Without creation of a grid-view of all the merged videos (faster)**
      ```
      tesla-dashcam-merge.sh
      ```
  
      You will see the merged files inside the folder:
        -  back.mp4
        -  front.mp4
        -  left_repeater.mp4
        -  right_repeater.mp4
      <img width="673" alt="スクリーンショット 2024-04-27 21 27 03" src="https://github.com/akiyamasho/tesla-dashcam-merge/assets/35907066/f9d4114f-310a-44f0-a997-f4866ff82b38">
    - **With creation of a grid-view video**
      ```
      tesla-dashcam-merge.sh --merge-grid
      ```
      In addition to the merged files, you will see a `merged-output.mp4` file that shows all the merged videos in a grid:
      <img width="1140" alt="スクリーンショット 2024-04-27 21 29 21" src="https://github.com/akiyamasho/tesla-dashcam-merge/assets/35907066/44b8ef6d-3bbf-43e8-9b7e-24ed67c35ac8">

### About

Created this script since I almost got hit by a shrapnel from a truck with uncovered cargo lol.
Hope it helps others review footage more easily.
