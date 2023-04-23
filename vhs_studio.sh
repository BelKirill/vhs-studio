#!bin/zsh

set_up_studio() {
  zsh modules/studio_setup.sh
  main_menu
}

prepare_tapes() {
  zsh modules/tape_settings.sh
  main_menu
}

record_videos() {
  zsh modules/recording_studio.sh
  main_menu
}

main_menu() {
  STUDIO_CHOICE=$(gum choose "Set up studio" "Prepare Tapes" "Record Videos" "Exit studio")

  case when $STUDIO_CHOICE in
    "Set up studio")
      set_up_studio
      ;;
    "Prepare Tapes")
      prepare_tapes
      ;;
    "Record Videos")
      record_videos
      ;;
    *)
      echo "Good bye!"
      ;;
  esac
}

main_menu

