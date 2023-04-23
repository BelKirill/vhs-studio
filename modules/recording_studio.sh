#!bin/zsh

set_up_studio() {
  SETUP=setup.studio
  echo "Setting up studio!"

  echo "Set Shell 'zsh'" > $SETUP
  echo "" >> $SETUP

  echo "Select font:"
  FONT=$(gum choose "Monofur Nerd Font Mono" --selected="Monofur Nerd Font Mono") 
  echo "Select font size:"
  FONT_SIZE=$(gum input --placeholder="Enter font size..." --value=18)

  echo "Set FontFamily '$FONT'" >> $SETUP
  echo "Set FontSize $FONT_SIZE" >> $SETUP
  echo "" >> $SETUP

  echo "Set Width 840" >> $SETUP
  echo "Set Height 840" >> $SETUP
  echo "Set Padding 20" >> $SETUP
  echo "" >> $SETUP

  echo "Set Theme 'Gruvbox Dark'" >> $SETUP
  echo "" >> $SETUP

  echo "Done setting up studio"
  main_menu
}

prepare_tapes() {
  echo "Preparing Tapes"

  ALL_SCRIPTS=FALSE
  gum confirm "Prepare all scripts?" && ALL_SCRIPTS=TRUE

  if $ALL_SCRIPTS
  then
    TAPE_NAMES=$(ls *.script | cut -d "." -f 1)
  else
    TAPE_NAMES=$(ls *.script | gum filter --placeholder="Select scripts to prepare" --no-limit | cut -d "." -f 1)
  fi

  for TAPE_NAME in $TAPE_NAMES
  do
    TAPE="tapes/$TAPE_NAME.tape"
    SCRIPT="$TAPE_NAME.script"
    MOVIE="video/$TAPE_NAME.mp4"

    cat setup.studio > "$TAPE"
    echo "\n" >> "$TAPE"
    echo "Output '$MOVIE'" >> "$TAPE"
    echo "\n" >> "$TAPE"
    cat $SCRIPT >> "$TAPE"
  done

  echo "Tapes prepared"
  main_menu
}

record_videos() {
  ALL_TAPES=FALSE
  gum confirm "Prepare all tapes?" && ALL_TAPES=TRUE

  if $ALL_TAPES
  then
    TAPE_NAMES=$(ls tapes/*.tape | cut -d "." -f 1)
  else
    TAPE_NAMES=$(ls tapes/*.tape | gum filter --placeholder="Select tapes to prepare" --no-limit | cut -d "." -f 1)
  fi

  for TAPE_NAME in $TAPE_NAMES
  do
    TAPE="$TAPE_NAME.tape"

    gum format "# Recording $TAPE"

    vhs < $TAPE
  done

  echo "videos recorded"
  main_menu
}

main_menu() {
  STUDIO_CHOICE=$(gum choose "Set up studio" "Prepare Tapes" "Record Videos" "Exit studio")

  if [[ $STUDIO_CHOICE = "Set up studio" ]]
  then
    set_up_studio
  elif [[ $STUDIO_CHOICE = "Prepare Tapes" ]]
  then
    prepare_tapes
  elif [[ $STUDIO_CHOICE = "Record Videos" ]]
  then
    record_videos
  else
    echo "Good bye!"
  fi
}

main_menu

