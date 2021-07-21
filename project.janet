(declare-project
  :name "dtgb"
  :description "A datetime grab bag of functions"
  :dependencies ["https://github.com/andrewchambers/janet-sh.git"
                 "https://github.com/goto-engineering/testament"
                 "https://github.com/janet-lang/spork.git"])

(declare-source
  :source ["diff.janet"
           "dtgb.janet"
           "epoch.janet"
           "unix.janet"
           "util.janet"])
