(defun copy-to-x-clipboard ()
  "Copies selection to X11 clipboard"
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to X11 clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to X11 clipboard!")
          (deactivate-mark)
          )
      (message "No region active; can't yank to X11 clipboard!")
      )
    )
  )
(defun paste-from-x-clipboard ()
  "Pastes from X11 clipboard"
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )

(spacemacs/set-leader-keys "oy" 'copy-to-x-clipboard)
(spacemacs/set-leader-keys "op" 'paste-from-x-clipboard)
