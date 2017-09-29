#lang racket/gui
(require file/md5)
; (c) 2017 Alexander Sharikhin
; This software was made just for fun.
; Feel free to use it in any way without any warranty
; Passwords generates by "cutting" md5 of master password and service name
; There you can manage what part of md5 string will be in password
(define skip-symbols 3)
(define stop-at-symbol 15)

; And here our gui
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
                             [callback (λ (button event) ; Will think that every event is click
                                         (send password-field set-value
                                               (substring (bytes->string/utf-8 (md5 (string-append
                                                                                     (send master-password-field get-value)
                                                                                     (send service-field get-value))))
                                                          skip-symbols stop-at-symbol )))])))
  (send frame show #t))