#lang racket/gui

(require file/md5)

(let* ((frame (new frame% [label "Password Racket"]))
       (main-panel (new vertical-panel%
                        [parent frame]
                        [border 3]))
       (master-password-field (new text-field%
                                   [label "Master password"]
                                   [style '(single password)]
                                   [parent main-panel]))
       (service-field (new text-field%
                           [label "Service"]
                           [parent main-panel]))
       (password-field (new text-field%
                            [label "Password"]
                            [parent main-panel]))
       (generate-button (new button%
                             [parent main-panel]
                             [label "Generate"]
                             [callback (λ (button event)
                                         (send password-field set-value
                                               (substring (bytes->string/utf-8 (md5 (string-append
                                                                                     (send master-password-field get-value)
                                                                                     (send service-field get-value))))
                                                          3 15 )))])))
  (send frame show #t))