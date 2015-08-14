;;; jde-interactive.el --- The JVM backend for JDE. -*- lexical-binding: t -*-

;; Version: 0.1-SNAPSHOT
;; Package-Version: 0.1snapshot
;; Package-Requires: ((jde "0.1"))

;; The contents of this file are subject to the GPL License, Version 3.0.

(defconst jde-interactive-version "0.1-SNAPSHOT")


;;;###autoload
(defun jde-interactive-jack-in ()
  (interactive)
  ;; start a maven process which, connect to the nrepl client, check the
  ;; versions of the middle ware
  
  )

;;;###autoload
(define-minor-mode jde-interactive-mode
  "Minor mode for JVM/Clojure interaction from a Java buffer."
  )

(provide 'jde-interactive)
;;; jde-interactive.el ends here
