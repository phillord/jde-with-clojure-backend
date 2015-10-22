;;; jdee-live.el --- The JVM backend for JDE. -*- lexical-binding: t -*-

;; Version: 0.1
;; Package-Requires: ((cider "20151020.646")(load-relative "20150224.1722"))

;;; Commentary:
;;  Prototype nrepl backend


;;; Code:
;; The contents of this file are subject to the GPL License, Version 3.0.
(require 'cider-client)
(require 'cider)
(require 'load-relative)

(defconst jdee-live-version "0.1-SNAPSHOT")

(defvar jdee-live-launch-script
  (relative-expand-file-name "clj/jdee-launch-nrepl.clj"))

(defun jdee-live-project-directory-for (dir-name)
  (when dir-name
    (locate-dominating-file dir-name "pom.xml")))

;;;###autoload
(defun jdee-live-jack-in ()
  (interactive)
  ;; start a maven process which, connect to the nrepl client, check the
  ;; versions of the middle ware
  (let* ((project-dir
          (jdee-live-project-directory-for (cider-current-dir))))
    (-when-let (repl-buff (cider-find-reusable-repl-buffer nil project-dir))
      (let* ((nrepl-create-client-buffer-function #'cider-repl-create)
             (nrepl-use-this-as-repl-buffer repl-buff)
             (serv-proc
              (nrepl-start-server-process
               project-dir
               ;; TODO: FIXME: generalise!
               (format
                (concat "mvn jdee:jdee-maven-nrepl:java "
                        "-Dexec.mainClass=\"clojure.main\""
                        " -Dexec.args=\"%s\""
                        " -Dexec.includePluginsDependencies=true"
                        )
                jdee-live-launch-script))))
        ;; FIXME: clojure:nrepl drops strange strings out!
        (set-process-filter serv-proc #'jdee-live-server-filter)))))

(defun jdee-live-server-filter (process output)
  "Process nREPL server output from PROCESS contained in OUTPUT."
  (with-current-buffer (process-buffer process)
    (save-excursion
      (goto-char (point-max))
      (insert output)))
  (message "checking %s" output)
  (when (string-match "nREPL server started on port \\([0-9]+\\)" output)
    (let ((port (string-to-number (match-string 1 output))))
      (message (format "nREPL server started on %s" port))
      (with-current-buffer (process-buffer process)
        (let ((client-proc (nrepl-start-client-process nil port process)))
          ;; FIXME: Bad connection tracking system. There can be multiple client
          ;; connections per server
          (setq nrepl-connection-buffer (buffer-name (process-buffer client-proc))))))))



;;;###autoload
(define-minor-mode jdee-live-mode
  "Minor mode for JVM/Clojure interaction from a Java buffer."
  )

(provide 'jdee-live)
;;; jdee-live.el ends here
