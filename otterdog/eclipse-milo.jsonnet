local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('iot.milo', 'eclipse-milo') {
  settings+: {
    description: "",
    name: "Eclipse Milo Project",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('ORG_GPG_KEY_ID') {
      value: 'pass:bots/iot.milo/gpg/key_id',
    },
    orgs.newOrgSecret('ORG_GPG_PASSPHRASE') {
      value: 'pass:bots/iot.milo/gpg/passphrase',
    },
    orgs.newOrgSecret('ORG_GPG_PRIVATE_KEY') {
      value: 'pass:bots/iot.milo/gpg/secret-subkeys.asc',
    },
    orgs.newOrgSecret('ORG_OSSRH_PASSWORD') {
      value: 'pass:bots/iot.milo/oss.sonatype.org/password',
    },
    orgs.newOrgSecret('ORG_OSSRH_USERNAME') {
      value: 'pass:bots/iot.milo/oss.sonatype.org/username',
    },
  ],
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/milo/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
    },
    orgs.newRepo('milo') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "java-kotlin"
      ],
      code_scanning_default_setup_enabled: true,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: " Eclipse Milo™ - an open source implementation of OPC UA (IEC 62541).",
      has_discussions: true,
      homepage: "http://www.eclipse.org/milo",
      private_vulnerability_reporting_enabled: true,
      topics+: [
        "client",
        "iec-62541",
        "iec62541",
        "industrial-automation",
        "iot",
        "java",
        "milo",
        "opc-ua",
        "opcua",
        "sdk",
        "server",
        "stack"
      ],
      web_commit_signoff_required: false,
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/milo/github-webhook/') {
          events+: [
            "push"
          ],
        },
        orgs.newRepoWebhook('https://ci.eclipse.org/milo/ghprbhook/') {
          events+: [
            "issue_comment",
            "pull_request"
          ],
        },
        orgs.newRepoWebhook('https://ci-staging.eclipse.org/milo/ghprbhook/') {
          events+: [
            "issue_comment",
            "pull_request"
          ],
        },
        orgs.newRepoWebhook('https://ci-staging.eclipse.org/milo/github-webhook/') {
          events+: [
            "push"
          ],
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
  ],
}
