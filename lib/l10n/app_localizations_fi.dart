// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String about_dialog_app_publisher(String p0) {
    return 'Julkaisija: $p0';
  }

  @override
  String about_dialog_git_commit_id(String p0) {
    return 'Versiotunniste: $p0';
  }

  @override
  String get account_ban_reason_category_chat_message => 'Chat-viesti';

  @override
  String get account_ban_reason_category_image => 'Kuva';

  @override
  String get account_ban_reason_category_profile_name => 'Profiilinimi';

  @override
  String get account_ban_reason_category_profile_text => 'Profiiliteksti';

  @override
  String get account_ban_reason_category_report_spam => 'Ilmoitusten roskapostitus';

  @override
  String account_banned_screen_ban_reason(String p0) {
    return 'Syy: $p0';
  }

  @override
  String account_banned_screen_ban_reason_category(String p0) {
    return 'Kategoria: $p0';
  }

  @override
  String account_banned_screen_time_text(String p0) {
    return 'Porttikiellon poistoprosessi alkaa $p0';
  }

  @override
  String get account_banned_screen_title => 'Tilillä porttikielto';

  @override
  String account_deletion_pending_screen_time_text(String p0) {
    return 'Tilin poistoprosessi alkaa $p0';
  }

  @override
  String get account_deletion_pending_screen_title => 'Tilin poisto vireillä';

  @override
  String get account_settings_screen_cancel_email_change_button =>
      'Peruuta sähköpostiosoitteen vaihto';

  @override
  String get account_settings_screen_cancel_email_change_confirm_dialog_title =>
      'Peruuta sähköpostiosoitteen vaihto?';

  @override
  String get account_settings_screen_change_email_button => 'Vaihda sähköpostiosoite';

  @override
  String get account_settings_screen_change_email_dialog_hint => 'Syötä uusi sähköpostiosoite';

  @override
  String get account_settings_screen_change_email_dialog_title => 'Vaihda sähköpostiosoite';

  @override
  String get account_settings_screen_change_email_local_auth_reason =>
      'Vahvista henkilöllisyytesi vaihtaaksesi sähköpostiosoitteen';

  @override
  String get account_settings_screen_delete_account_action => 'Pyydä tilin poistamista';

  @override
  String get account_settings_screen_delete_account_action_error =>
      'Tilin poistopyyntö epäonnistui';

  @override
  String get account_settings_screen_delete_account_confirm_dialog_title =>
      'Pyydä tilin poistamista?';

  @override
  String get account_settings_screen_email_change_cancelled =>
      'Sähköpostiosoitteen vaihto peruutettu';

  @override
  String account_settings_screen_email_change_history_limit_reached(String p0) {
    return 'Sähköpostiosoitteen vaihtoraja saavutettu. Yritä uudelleen $p0 kuluttua.';
  }

  @override
  String get account_settings_screen_email_change_initiated =>
      'Sähköpostiosoitteen vaihto aloitettu. Tarkista sähköpostisi.';

  @override
  String get account_settings_screen_email_not_verified => 'Sähköpostia ei ole vahvistettu';

  @override
  String get account_settings_screen_email_title => 'Sähköpostiosoite';

  @override
  String get account_settings_screen_email_verified => 'Sähköposti vahvistettu';

  @override
  String account_settings_screen_pending_email_completion_time(String p0) {
    return 'Sähköpostiosoitteen vaihto valmistuu: $p0';
  }

  @override
  String get account_settings_screen_pending_email_not_verified =>
      'Uusi sähköpostiosoite ei ole vahvistettu';

  @override
  String get account_settings_screen_pending_email_title => 'Uusi sähköpostiosoite';

  @override
  String get account_settings_screen_pending_email_verified => 'Uusi sähköpostiosoite vahvistettu';

  @override
  String get account_settings_screen_send_verification_email_already_verified =>
      'Sähköposti on jo vahvistettu';

  @override
  String get account_settings_screen_send_verification_email_button => 'Lähetä vahvistussähköposti';

  @override
  String get account_settings_screen_send_verification_email_sent_successfully =>
      'Vahvistussähköposti lähetetty';

  @override
  String get account_settings_screen_title => 'Tili';

  @override
  String get account_verification_screen_error_profile_age_range_mismatch =>
      'Ikäsi (profiilissasi) muuttui vahvistuksen aikana';

  @override
  String get account_verification_screen_error_profile_age_range_verification_failed =>
      'Iän vahvistus epäonnistui';

  @override
  String get account_verification_screen_error_profile_age_range_verification_mismatch =>
      'Vahvistettu ikä ei vastaa ikääsi profiilissasi';

  @override
  String get account_verification_screen_error_profile_name_mismatch =>
      'Profiilinimi muuttui vahvistuksen aikana';

  @override
  String get account_verification_screen_error_profile_name_verification_failed =>
      'Nimen vahvistus epäonnistui';

  @override
  String get account_verification_screen_error_profile_name_verification_mismatch =>
      'Vahvistettu nimi ei vastaa profiilinimeä';

  @override
  String get account_verification_screen_error_security_content_mismatch =>
      'Moderointiselfie muuttui vahvistuksen aikana';

  @override
  String get account_verification_screen_error_security_content_verification_failed =>
      'Moderointiselfien vahvistus epäonnistui';

  @override
  String get account_verification_screen_error_security_content_verification_mismatch =>
      'Vahvistettu kuva ei vastaa moderointiselfietäsi';

  @override
  String get account_verification_screen_previous_verification_errors_title => 'Virheet';

  @override
  String account_verification_screen_previous_verification_time(String p0) {
    return 'Aika: $p0';
  }

  @override
  String get account_verification_screen_previous_verification_title => 'Edellinen vahvistus';

  @override
  String account_verification_screen_queue_position(String p0) {
    return 'Jonosija: $p0';
  }

  @override
  String get account_verification_screen_request_initial_setup_not_completed =>
      'Profiilia ei ole vielä määritetty';

  @override
  String get account_verification_screen_request_queue_full =>
      'Vahvistusjono on täynnä. Yritä myöhemmin uudelleen.';

  @override
  String get account_verification_screen_scope_profile_age => 'Ikä';

  @override
  String get account_verification_screen_scope_profile_name => 'Etunimi';

  @override
  String get account_verification_screen_start_verification_title =>
      'Valitse vahvistuskohteet ja -tapa';

  @override
  String get account_verification_screen_title => 'Tilin vahvistus';

  @override
  String get account_verification_screen_verification_in_progress_title => 'Vahvistus käynnissä';

  @override
  String get admin_settings_title => 'Ylläpito';

  @override
  String get age_verification_required_screen_title => 'Iän vahvistus vaaditaan';

  @override
  String get age_verification_required_screen_verify_age_action => 'Vahvista ikä';

  @override
  String get age_verification_screen_age_is_18_or_older => 'Ikä on vähintään 18 vuotta';

  @override
  String get age_verification_screen_current_verification_status_title => 'Nykyinen vahvistustila';

  @override
  String get age_verification_screen_error_age_already_verified => 'Ikä on jo vahvistettu';

  @override
  String get age_verification_screen_error_age_under_18 => 'Täytyy olla vähintään 18-vuotias';

  @override
  String get age_verification_screen_start_verification_title => 'Aloita vahvistus';

  @override
  String get age_verification_screen_title => 'Iän vahvistus';

  @override
  String get app_bar_action_about => 'Tietoja';

  @override
  String get app_legalese => '';

  @override
  String get app_name => 'Afrodite';

  @override
  String get app_publisher => '';

  @override
  String get app_slogan => 'Deittisovellus';

  @override
  String get app_update_available_dialog_description_manual_update =>
      'Uusi versio on saatavilla. Päivitä sovellus.';

  @override
  String get app_update_available_dialog_description_update_now =>
      'Uusi versio on saatavilla. Päivitetäänkö nyt?';

  @override
  String get app_update_available_dialog_description_web_restart =>
      'Uusi versio on saatavilla. Käynnistä sovellus uudelleen päivittääksesi.';

  @override
  String get association_membership_screen_current_membership_title => 'Nykyinen jäsenyys';

  @override
  String get association_membership_screen_domicile_label => 'Kotipaikka';

  @override
  String get association_membership_screen_end_membership_button => 'Lopeta jäsenyys';

  @override
  String get association_membership_screen_end_membership_confirm_title => 'Lopeta jäsenyys?';

  @override
  String get association_membership_screen_full_name_label => 'Täydellinen nimi';

  @override
  String get association_membership_screen_join_button => 'Liity';

  @override
  String get association_membership_screen_membership_type_label => 'Jäsenyystyyppi';

  @override
  String get association_membership_screen_title => 'Yhdistyksen jäsenyys';

  @override
  String attribute_deprecated_info(String p0) {
    return '\"$p0\" on vanhentunut ja poistuu, kun sen valinta poistetaan';
  }

  @override
  String attribute_partially_hidden_info(String p0) {
    return '\"$p0\" on osittain piilotettu';
  }

  @override
  String get automatic_profile_search_results_screen_no_profiles_found_description =>
      'Saat ilmoituksen, kun tilanne muuttuu';

  @override
  String get automatic_profile_search_results_screen_no_profiles_found_title =>
      'Uusia tai päivitettyjä profiileja ei löytynyt';

  @override
  String get automatic_profile_search_results_screen_title => 'Uudet ja päivitetyt profiilit';

  @override
  String get blocked_profiles_screen_no_blocked_profiles => 'Ei estettyjä profiileja';

  @override
  String get blocked_profiles_screen_placeholder_for_private_profile => 'Yksityinen profiili';

  @override
  String get blocked_profiles_screen_title => 'Estetyt profiilit';

  @override
  String blocked_profiles_screen_unblock_profile_dialog_description(String p0) {
    return 'Poista profiilin $p0 esto';
  }

  @override
  String get blocked_profiles_screen_unblock_profile_dialog_title => 'Poista profiilin esto?';

  @override
  String get blocked_profiles_screen_unblock_profile_failed =>
      'Profiilin eston poistaminen epäonnistui';

  @override
  String get blocked_profiles_screen_unblock_profile_in_progress =>
      'Edellinen eston poisto on kesken';

  @override
  String get blocked_profiles_screen_unblock_profile_successful => 'Profiilin esto poistettu';

  @override
  String get camera_screen_camera_access_restricted_error =>
      'Kameran käyttö on estetty tällä laitteella.';

  @override
  String get camera_screen_camera_initialization_error => 'Kameran avaaminen epäonnistui';

  @override
  String camera_screen_camera_initialization_error_with_error_code(String p0) {
    return 'Kameran avaaminen epäonnistui (virhe $p0)';
  }

  @override
  String get camera_screen_camera_opening_already_in_progress_error =>
      'Kamera on jo käynnistymässä';

  @override
  String get camera_screen_camera_permission_error_check_settings =>
      'Kameran käyttöoikeus vaaditaan. Myönnä kameran käyttöoikeus järjestelmäasetuksista.';

  @override
  String get camera_screen_camera_permission_error_try_again_or_check_settings =>
      'Kameran käyttöoikeus vaaditaan. Yritä uudelleen. Saatat joutua myöntämään luvan järjestelmäasetuksista.';

  @override
  String get camera_screen_no_front_camera_error => 'Etukameraa ei löytynyt';

  @override
  String get camera_screen_take_photo_error => 'Kuvan ottaminen epäonnistui';

  @override
  String get chat_backup_connecting => 'Yhdistetään…';

  @override
  String get chat_backup_data_stream_unsupported => 'Ei tuettu tietovirta';

  @override
  String get chat_backup_database_not_found => 'Keskustelutietoja ei löytynyt tälle tilille';

  @override
  String get chat_backup_pairing_code_invalid => 'Virheellinen parituskoodi';

  @override
  String get chat_backup_pairing_code_label => 'Laitteen parituskoodi';

  @override
  String get chat_backup_pairing_code_unsupported => 'Ei tuettu parituskoodiversio';

  @override
  String get chat_backup_reminder_dialog_message_no_backup =>
      'Keskusteluvarmuuskopiota ei ole vielä luotu. Varmuuskopioidaanko nyt?';

  @override
  String chat_backup_reminder_dialog_message_old_backup(String p0) {
    return 'Keskusteluvarmuuskopiota ei ole luotu $p0 päivään. Varmuuskopioidaanko nyt?';
  }

  @override
  String get chat_backup_reminder_dialog_title => 'Keskusteluvarmuuskopio';

  @override
  String get chat_backup_screen_backup_reminder_interval_day => 'Joka päivä';

  @override
  String chat_backup_screen_backup_reminder_interval_days(String p0) {
    return 'Joka $p0. päivä';
  }

  @override
  String get chat_backup_screen_import_backup_question => 'Tuo keskusteluvarmuuskopio?';

  @override
  String chat_backup_screen_import_backup_question_details(String p0) {
    return 'Tiedosto: $p0\n\nNykyiset ja varmuuskopion viestit yhdistetään. Nykyinen salausavain korvataan, jos varmuuskopion avain on uudempi.';
  }

  @override
  String get chat_backup_screen_import_error_invalid_backup_file =>
      'Virheellinen varmuuskopiotiedosto';

  @override
  String get chat_backup_screen_import_error_unsupported_version => 'Ei tuettu varmuuskopioversio';

  @override
  String get chat_backup_screen_import_error_wrong_account => 'Varmuuskopio on luotu eri tilillä';

  @override
  String get chat_backup_screen_title => 'Keskusteluvarmuuskopio';

  @override
  String get chat_backup_transfer_budget_exceeded =>
      'Vuosittainen siirtoraja saavutettu. Tallenna varmuuskopio ja siirrä se manuaalisesti.';

  @override
  String get chat_data_outdated_description =>
      'Laite vaihtunut tai sovellus asennettu uudelleen. Siirretäänkö keskustelut vanhalta laitteeltasi?';

  @override
  String get chat_data_outdated_error_too_many_keys =>
      'Salausavainten enimmäismäärä saavutettu. Vastaanota varmuuskopio vanhalta laitteeltasi tai ota yhteyttä tukeen.';

  @override
  String get chat_data_outdated_pending_messages_warning =>
      'Sinulla on lukemattomia viestejä salattuna vanhalla salausavaimellasi. Lukeaksesi ne siirrä keskustelutiedot edelliseltä laitteeltasi tai palauta salausavaimen sisältävä varmuuskopio.\n\nJos jatkat, et voi lukea kyseisiä viestejä. Jatketaanko silti?';

  @override
  String get chat_data_outdated_receive_backup => 'Vastaanota varmuuskopio';

  @override
  String get chat_data_outdated_title => 'Keskustelutiedot vanhentuneet';

  @override
  String get chat_list_screen_no_chats_found => 'Ei keskusteluja vielä';

  @override
  String get chat_list_screen_no_chats_found_description =>
      'Kerro sovelluksesta sosiaalisessa mediassa';

  @override
  String get chat_list_screen_no_matches_found => 'Ei hyväksyttyjä keskustelupyyntöjä vielä';

  @override
  String get chat_list_screen_open_matches_screen_action => 'Hyväksytyt keskustelupyynnöt';

  @override
  String get chat_list_screen_profile_not_available => 'Profiili ei saatavilla';

  @override
  String chat_list_screen_sent_message_indicator(String p0) {
    return 'Sinä: $p0';
  }

  @override
  String get chat_list_screen_title => 'Keskustelut';

  @override
  String get chat_list_screen_unread_message => 'Uusi viesti';

  @override
  String content_management_screen_content_deletion_allowed_wait_time(String p0) {
    return 'Voidaan poistaa alkaen $p0';
  }

  @override
  String get content_management_screen_content_face_not_verified => 'Kasvoja ei ole vahvistettu';

  @override
  String get content_management_screen_content_face_verification_pending =>
      'Kasvojen vahvistus odottaa';

  @override
  String get content_management_screen_content_face_verified => 'Kasvot vahvistettu';

  @override
  String content_management_screen_content_profile_content(String p0) {
    return 'Profiilikuva $p0';
  }

  @override
  String get content_management_screen_title => 'Omat kuvat';

  @override
  String get conversation_screen_chat_box_placeholder_text => 'Kirjoita viesti…';

  @override
  String get conversation_screen_install_jitsi_meet_dialog_description_android =>
      'Videopuhelut vaativat Jitsi Meet -sovelluksen. Haluatko asentaa sen Google Play Kaupasta?';

  @override
  String get conversation_screen_install_jitsi_meet_dialog_description_ios =>
      'Videopuhelut vaativat Jitsi Meet -sovelluksen. Haluatko asentaa sen App Storesta?';

  @override
  String get conversation_screen_install_jitsi_meet_dialog_title => 'Asenna Jitsi Meet?';

  @override
  String get conversation_screen_join_video_call_button => 'Liity videopuheluun';

  @override
  String get conversation_screen_join_video_call_dialog_title => 'Liity videopuheluun?';

  @override
  String get conversation_screen_make_match_instruction =>
      'Lähetä viesti hyväksyäksesi keskustelupyynnön!';

  @override
  String get conversation_screen_message_details_message_id => 'Viestitunniste';

  @override
  String get conversation_screen_message_details_message_number => 'Viestin numero';

  @override
  String get conversation_screen_message_error_is_actually_sent_successfully =>
      'Tämä viesti lähetettiin jo onnistuneesti';

  @override
  String get conversation_screen_message_error_recipient_blocked_sender_or_recipient_not_found =>
      'Viestiä ei voitu toimittaa vastaanottajalle';

  @override
  String conversation_screen_message_info_encryption_key_changed(String p0) {
    return 'Käyttäjän $p0 salausavain muuttui';
  }

  @override
  String get conversation_screen_message_info_encryption_started =>
      'Viestit ovat päästä päähän -salattuja';

  @override
  String get conversation_screen_message_list_empty => 'Ei viestejä vielä';

  @override
  String get conversation_screen_message_not_found => 'Viestiä ei löytynyt';

  @override
  String get conversation_screen_message_resend_complete => 'Uudelleenlähetetty onnistuneesti';

  @override
  String get conversation_screen_message_resend_confirm_title => 'Lähetä uudelleen?';

  @override
  String conversation_screen_message_resent_info(String p0, String p1) {
    return 'Uudelleenlähetetty (alun perin lähetetty $p0, viesti $p1)';
  }

  @override
  String get conversation_screen_message_send_requires_connection =>
      'Yritä uudelleen, kun sovellus yhdistää palvelimeen';

  @override
  String get conversation_screen_message_state_decrypting_failed => 'Salauksen purku epäonnistui';

  @override
  String get conversation_screen_message_state_decrypting_failed_detailed =>
      'Salausta ei voitu purkaa. Pyydä lähettäjää lähettämään viesti uudelleen.';

  @override
  String get conversation_screen_message_state_delivered => 'Toimitettu';

  @override
  String get conversation_screen_message_state_delivery_failed => 'Toimitus epäonnistui';

  @override
  String get conversation_screen_message_state_delivery_failed_and_resent =>
      'Toimitus epäonnistui, lähetetty uudelleen';

  @override
  String get conversation_screen_message_state_public_key_download_failed =>
      'Salausavaimen lataus epäonnistui';

  @override
  String get conversation_screen_message_state_received_and_seen => 'Nähty';

  @override
  String get conversation_screen_message_state_received_and_seen_locally => 'Nähty paikallisesti';

  @override
  String get conversation_screen_message_state_received_successfully => 'Vastaanotettu';

  @override
  String get conversation_screen_message_state_seen => 'Nähty';

  @override
  String get conversation_screen_message_state_sending_failed => 'Lähetys epäonnistui';

  @override
  String get conversation_screen_message_state_sending_in_progress => 'Lähetetään…';

  @override
  String get conversation_screen_message_state_sent_successfully => 'Lähetetty';

  @override
  String get conversation_screen_message_too_long => 'Viesti on liian pitkä';

  @override
  String get conversation_screen_message_too_many_pending_messages =>
      'Liian monta toimittamatonta viestiä';

  @override
  String get conversation_screen_message_unsupported => 'Ei tuettu viestimuoto';

  @override
  String get conversation_screen_open_details_action_subtitle => 'Sisältää valittavaa tekstiä';

  @override
  String get conversation_screen_profile_blocked => 'Profiili estettiin';

  @override
  String conversation_screen_remaining_conversation_messages(String p0) {
    return 'Viestejä jäljellä tähän keskusteluun: $p0 (nollautuu toimituksen jälkeen)';
  }

  @override
  String conversation_screen_remaining_daily_messages(String p0) {
    return 'Päivittäisiä viestejä jäljellä: $p0';
  }

  @override
  String get conversation_screen_send_video_call_invitation_action => 'Lähetä videopuhelukutsu';

  @override
  String get conversation_screen_send_video_call_invitation_dialog_title =>
      'Lähetä videopuhelukutsu?';

  @override
  String get crop_image_screen_title => 'Rajaa kuva';

  @override
  String get current_security_selfie_screen_security_selfie_changed =>
      'Moderointiselfie päivitetty';

  @override
  String get data_export_screen_api_limit_error =>
      'Päivittäinen raja saavutettu. Yritä uudelleen 24 tunnin kuluttua.';

  @override
  String get data_export_screen_title_export_type_admin => 'Tietojen vienti';

  @override
  String get data_export_screen_title_export_type_user => 'Lataa omat tiedot';

  @override
  String get demo_account_screen_confirm_logout_dialog_title => 'Kirjaudu ulos?';

  @override
  String get demo_account_screen_login_to_account_dialog_title => 'Kirjaudu tilille?';

  @override
  String get demo_account_screen_max_account_count_error =>
      'Virhe: tilien enimmäismäärä saavutettu';

  @override
  String get demo_account_screen_new_account_action => 'Uusi tili';

  @override
  String get demo_account_screen_new_account_dialog_description =>
      'Luo uusi tili ja kirjaudu siihen?';

  @override
  String get demo_account_screen_no_accounts_available => 'Tilejä ei saatavilla';

  @override
  String get edit_attribute_filter_value_screen_require_all_wanted_values =>
      'Vaadi kaikki halutut arvot';

  @override
  String get edit_attribute_filter_value_screen_search_placeholder_text => 'Hae…';

  @override
  String get edit_attribute_filter_value_screen_show_advanced_filters_action => 'Lisäsuodattimet';

  @override
  String get edit_attribute_filter_value_screen_show_basic_filters_action => 'Perussuodattimet';

  @override
  String get edit_attribute_filter_value_screen_title => 'Muokkaa suodatinta';

  @override
  String get edit_attribute_value_screen_max_selected_values_error =>
      'Liian monta vaihtoehtoa valittu';

  @override
  String get edit_attribute_value_screen_one_value_must_be_selected =>
      'Vähintään yksi vaihtoehto on valittava';

  @override
  String get edit_attribute_value_screen_search_placeholder_text => 'Hae…';

  @override
  String get edit_my_gender_screen_gender_setting_title => 'Profiilini sukupuoli';

  @override
  String edit_profile_screen_automatic_min_age_incrementing_info_dialog_text(String p0, String p1) {
    return 'Minimi-ikä nostetaan arvoon $p0 ajassa $p1';
  }

  @override
  String get edit_profile_screen_invalid_age => 'Virheellinen ikä';

  @override
  String get edit_profile_screen_invalid_profile_name => 'Virheellinen etunimi';

  @override
  String get edit_profile_screen_one_profile_image_required =>
      'Vähintään yksi profiilikuva vaaditaan';

  @override
  String get edit_profile_screen_primary_profile_content_pending_moderation =>
      'Kuva ei ole tällä hetkellä moderaattorin hyväksymä. Profiilisi ei näy profiiliruudukossa ennen kuin kuva on hyväksytty.';

  @override
  String get edit_profile_screen_primary_profile_content_rejected =>
      'Moderaattori hylkäsi kuvan. Vaihda kuva, jotta profiilisi näkyy profiiliruudukossa.';

  @override
  String get edit_profile_screen_profile_name => 'Etunimi';

  @override
  String get edit_profile_screen_profile_name_description =>
      'Etunimen muuttaminen on mahdollista vain ennen kuin moderaattorit ovat hyväksyneet sen.';

  @override
  String get edit_profile_screen_profile_text => 'Profiiliteksti';

  @override
  String get edit_profile_screen_title => 'Muokkaa profiilia';

  @override
  String get edit_profile_screen_unlimited_likes => 'Treffiseuraa tälle päivälle';

  @override
  String edit_profile_screen_unlimited_likes_description_enabled_and_automatic_disabling(
    String p0,
  ) {
    return 'Kytkeytyy pois päältä klo $p0';
  }

  @override
  String get edit_profile_text_screen_text_length_too_long =>
      'Profiiliteksti on liian pitkä (enintään 2000 tavua)';

  @override
  String get email_login_method_screen_existing_account => 'Olemassa oleva tili';

  @override
  String get email_login_method_screen_existing_account_description =>
      'Kirjaudu tilille, joka sinulla jo on';

  @override
  String get email_login_method_screen_new_account => 'Uusi tili';

  @override
  String get email_login_method_screen_new_account_description => 'Luo uusi tili';

  @override
  String get email_login_method_screen_title => 'Kirjaudu sähköpostilla';

  @override
  String get email_login_screen_code_hint => 'Kirjautumiskoodi';

  @override
  String email_login_screen_did_not_receive_code(String p0) {
    return 'Jos et saanut koodia:\n• Tarkista roskapostikansio\n• Varmista, että sähköpostiosoite on oikein\n• Odota $p0 ennen uuden koodin pyytämistä\n• Varmista, että sinulla on olemassa oleva tili tällä sähköpostiosoitteella';
  }

  @override
  String email_login_screen_did_not_receive_code_registration(String p0) {
    return 'Jos et saanut koodia:\n• Tarkista roskapostikansio\n• Varmista, että sähköpostiosoite on oikein\n• Odota $p0 ennen uuden koodin pyytämistä';
  }

  @override
  String get email_login_screen_email_hint => 'Sähköpostiosoite';

  @override
  String email_login_screen_input_code_description(String p0) {
    return 'Syötä osoitteeseen $p0 lähetetty kirjautumiskoodi';
  }

  @override
  String get email_login_screen_login_only_info =>
      'Uuden tilin luominen ei ole tuettu tällä kirjautumistavalla';

  @override
  String get email_login_screen_registration_all_platforms_disabled_error =>
      'Uudet sähköpostirekisteröitymiset ovat tällä hetkellä poissa käytöstä. Käytä toista kirjautumistapaa.';

  @override
  String email_login_screen_registration_domain_not_accepted_error(String p0) {
    return 'Sähköpostiosoitteita verkkotunnuksella $p0 ei voi käyttää rekisteröitymiseen. Käytä toista sähköpostia tai kirjautumistapaa.';
  }

  @override
  String get email_login_screen_registration_info_dialog_text =>
      'Uuden tilin luominen sähköpostiosoitteella on rajoitettu tarkoituksellisesti bottien ja roskapostin vähentämiseksi. Käytä mieluiten tavanomaista kirjautumistapaasi (kuten Google tai Apple) aina kun mahdollista.\n\nJos käytät sähköpostiosoitettasi, yhdistäminen kodin kiinteästä laajakaistasta mobiilidatan sijaan voi auttaa välttämään IP-osoitekohtaisten rajojen saavuttamista.';

  @override
  String get email_login_screen_registration_ip_address_limit_reached_error =>
      'IP-osoitteesi päivittäinen rekisteröitymisraja on saavutettu. Yritä uudelleen 24 tunnin kuluttua tai käytä toista kirjautumistapaa.';

  @override
  String get email_login_screen_registration_limit_reached_error =>
      'Päivittäinen rekisteröitymisraja on saavutettu. Yritä uudelleen 24 tunnin kuluttua tai käytä toista kirjautumistapaa.';

  @override
  String get email_login_screen_registration_only_info =>
      'Huomaathan, että kertakäyttösähköpostipalveluiden käyttö on kielletty';

  @override
  String email_login_screen_registration_platform_disabled_error(String p0) {
    return 'Uudet sähköpostirekisteröitymiset ovat tällä hetkellä poissa käytöstä tällä alustalla ($p0). Käytä toista kirjautumistapaa.';
  }

  @override
  String get email_login_screen_registration_unsupported_email =>
      'Sähköpostiosoitetta ei tueta. Käytä toista kirjautumistapaa.';

  @override
  String get email_login_screen_send_code_button => 'Lähetä kirjautumiskoodi';

  @override
  String get email_login_screen_title => 'Sähköpostikirjautuminen';

  @override
  String get email_login_screen_title_register => 'Sähköpostirekisteröityminen';

  @override
  String email_login_screen_token_validity(String p0) {
    return 'Koodi vanhenee: $p0';
  }

  @override
  String get email_notification_settings_screen_title => 'Sähköposti-ilmoitukset';

  @override
  String generic_account_id_text_with_value(String p0) {
    return 'Tili ID: $p0';
  }

  @override
  String get generic_account_locked_error => 'Tili lukittu';

  @override
  String get generic_action_completed => 'Toiminto suoritettu';

  @override
  String get generic_age => 'Ikä';

  @override
  String get generic_average => 'Keskiarvo';

  @override
  String get generic_cancel => 'Peruuta';

  @override
  String get generic_cancel_question => 'Peruuta?';

  @override
  String get generic_close => 'Sulje';

  @override
  String get generic_continue => 'Jatka';

  @override
  String get generic_copied_to_clipboard => 'Kopioitu leikepöydälle';

  @override
  String get generic_copy => 'Kopioi';

  @override
  String get generic_create => 'Luo';

  @override
  String get generic_data_sync_failed => 'Tietojen synkronointi epäonnistui';

  @override
  String get generic_delete => 'Poista';

  @override
  String get generic_delete_question => 'Poista?';

  @override
  String get generic_details => 'Tiedot';

  @override
  String get generic_disable => 'Poista käytöstä';

  @override
  String get generic_disabled => 'Pois käytöstä';

  @override
  String get generic_download => 'Lataa';

  @override
  String get generic_download_question => 'Lataa?';

  @override
  String get generic_edit => 'Muokkaa';

  @override
  String get generic_email_sending_failed => 'Sähköpostin lähetys epäonnistui';

  @override
  String get generic_email_sending_timeout => 'Sähköpostin lähetys aikakatkaistiin';

  @override
  String get generic_empty => 'Tyhjä';

  @override
  String get generic_enable => 'Ota käyttöön';

  @override
  String get generic_error => 'Virhe';

  @override
  String get generic_error_app_version_is_unsupported => 'Nykyistä sovellusversiota ei enää tueta';

  @override
  String get generic_error_occurred => 'Jokin meni pieleen';

  @override
  String get generic_filters => 'Suodattimet';

  @override
  String get generic_gender_man => 'Mies';

  @override
  String get generic_gender_man_plural => 'Miehet';

  @override
  String get generic_gender_nonbinary => 'Muunsukupuolinen';

  @override
  String get generic_gender_nonbinary_plural => 'Muunsukupuoliset';

  @override
  String get generic_gender_woman => 'Nainen';

  @override
  String get generic_gender_woman_plural => 'Naiset';

  @override
  String get generic_import => 'Tuo';

  @override
  String get generic_large => 'Suuri';

  @override
  String get generic_later => 'Myöhemmin';

  @override
  String get generic_login => 'Kirjaudu';

  @override
  String get generic_login_progress_dialog_text => 'Kirjaudutaan…';

  @override
  String get generic_logout => 'Kirjaudu ulos';

  @override
  String get generic_logout_confirmation_title => 'Kirjaudu ulos?';

  @override
  String get generic_logout_failed => 'Uloskirjautuminen epäonnistui';

  @override
  String get generic_margin => 'Marginaali';

  @override
  String get generic_max => 'Maks';

  @override
  String get generic_medium => 'Keskikokoinen';

  @override
  String get generic_message => 'Viesti';

  @override
  String get generic_min => 'Min';

  @override
  String get generic_no => 'Ei';

  @override
  String get generic_not_found => 'Ei löytynyt';

  @override
  String get generic_ok => 'OK';

  @override
  String get generic_preview_noun => 'Esikatselu';

  @override
  String get generic_previous_action_in_progress => 'Edellinen toiminto on vielä kesken';

  @override
  String get generic_profile_loading_failed => 'Profiilin lataus epäonnistui';

  @override
  String get generic_receive => 'Vastaanota';

  @override
  String get generic_refresh => 'Päivitä';

  @override
  String get generic_remind => 'Muistuta';

  @override
  String get generic_reply => 'Vastaa';

  @override
  String get generic_report_verb => 'Ilmoita';

  @override
  String get generic_report_verb_question => 'Ilmoita?';

  @override
  String get generic_resend => 'Lähetä uudelleen';

  @override
  String get generic_reset_to_defaults => 'Palauta oletukset';

  @override
  String get generic_reset_to_defaults_dialog_title => 'Palauta oletukset?';

  @override
  String get generic_restore => 'Palauta';

  @override
  String get generic_retry => 'Yritä uudelleen';

  @override
  String get generic_save => 'Tallenna';

  @override
  String get generic_save_confirmation_title => 'Tallenna?';

  @override
  String get generic_security_selfie => 'Moderointiselfie';

  @override
  String get generic_setting_saved => 'Asetus tallennettu';

  @override
  String get generic_show_only_selected => 'Näytä vain valitut';

  @override
  String get generic_size => 'Koko';

  @override
  String get generic_skip => 'Ohita';

  @override
  String get generic_small => 'Pieni';

  @override
  String get generic_state => 'Tila';

  @override
  String get generic_take_photo => 'Ota kuva';

  @override
  String get generic_text_field_age_hint_text => 'Syötä ikä väliltä 18-99';

  @override
  String get generic_this_feature_is_disabled => 'Tämä ominaisuus on pois käytöstä';

  @override
  String get generic_time => 'Aika';

  @override
  String get generic_time_unit_hour => 't';

  @override
  String get generic_time_unit_minute => 'min';

  @override
  String get generic_time_unit_second => 's';

  @override
  String get generic_today => 'Tänään';

  @override
  String get generic_try_again => 'Yritä uudelleen';

  @override
  String generic_try_again_later_seconds(String p0) {
    return 'Yritä uudelleen $p0 sekunnin kuluttua';
  }

  @override
  String get generic_unlimited => 'Rajoittamaton';

  @override
  String get generic_unlink => 'Poista linkitys';

  @override
  String get generic_update => 'Päivitä';

  @override
  String get generic_warning => 'Varoitus';

  @override
  String get generic_weekday_fri => 'pe';

  @override
  String get generic_weekday_mon => 'ma';

  @override
  String get generic_weekday_sat => 'la';

  @override
  String get generic_weekday_sun => 'su';

  @override
  String get generic_weekday_thu => 'to';

  @override
  String get generic_weekday_tue => 'ti';

  @override
  String get generic_weekday_wed => 'ke';

  @override
  String get generic_yes => 'Kyllä';

  @override
  String get generic_yesterday => 'Eilen';

  @override
  String get generic_you => 'Sinä';

  @override
  String get image_processing_ui_confirm_photo_dialog_title => 'Jatketaanko tällä kuvalla?';

  @override
  String get image_processing_ui_nsfw_detected_dialog_title =>
      'Ladatussa kuvassa havaittiin kiellettyä sisältöä. Tämä saattaa olla väärä hälytys.';

  @override
  String get image_processing_ui_upload_content_processing_ongoing_dialog_title =>
      'Palvelin käsittelee vielä edellistä lähetystäsi';

  @override
  String get image_processing_ui_upload_failed_dialog_title => 'Lähetys epäonnistui';

  @override
  String image_processing_ui_upload_in_processing_queue_dialog_description(String p0) {
    return 'Jonossa. Sija: $p0';
  }

  @override
  String get image_processing_ui_upload_in_progress_dialog_description => 'Lähetetään kuvaa…';

  @override
  String get image_processing_ui_upload_processing_ongoing_description => 'Käsitellään kuvaa…';

  @override
  String get image_processing_ui_upload_timeout_dialog_title => 'Lähetys aikakatkaistiin';

  @override
  String get initial_setup_screen_age_confirmation_checkbox => 'Olen vähintään 18-vuotias';

  @override
  String get initial_setup_screen_age_confirmation_title => 'Iän vahvistus';

  @override
  String get initial_setup_screen_email_hint_text => 'Syötä sähköpostiosoite';

  @override
  String get initial_setup_screen_email_title => 'Sähköpostiosoitteeni on…';

  @override
  String get initial_setup_screen_first_chat_backup_backup_saved_successfully =>
      'Varmuuskopio tallennettu onnistuneesti';

  @override
  String get initial_setup_screen_first_chat_backup_description =>
      'Keskustelut tallennetaan vain tälle laitteelle, joten säännölliset varmuuskopiot ovat suositeltavia. Tallennetaan ensimmäinen varmuuskopiosi.\n\nJos käytät pilvitallennustilaa, varmuuskopion tallentaminen sinne on suositeltavaa.';

  @override
  String get initial_setup_screen_first_chat_backup_save_backup_button =>
      'Tallenna keskusteluvarmuuskopio';

  @override
  String get initial_setup_screen_first_chat_backup_security_info =>
      'Varmuuskopio sisältää salausavaimesi. Pidä se tallessa laitteen katoamisen varalta, jotta voit lukea kaikki sinulle lähetetyt viestit.';

  @override
  String get initial_setup_screen_first_chat_backup_skip_warning =>
      'Sovelluksen poistaminen poistaa keskustelusi ja salausavaimesi. Ilman avainta et voi lukea sinulle lähetettyjä viestejä.\n\nHaluatko varmasti ohittaa varmuuskopion luomisen?';

  @override
  String get initial_setup_screen_first_chat_backup_title => 'Ensimmäinen keskusteluvarmuuskopio';

  @override
  String get initial_setup_screen_gender_title => 'Olen…';

  @override
  String get initial_setup_screen_location_help_dialog_text =>
      'Napauta tai paina kohtaa kartalla asettaaksesi sijaintisi.';

  @override
  String get initial_setup_screen_location_title => 'Sijaintini on…';

  @override
  String get initial_setup_screen_profile_basic_info_profile_name_hint_text => 'Syötä etunimesi';

  @override
  String get initial_setup_screen_profile_basic_info_profile_name_title => 'Etunimi';

  @override
  String get initial_setup_screen_profile_basic_info_title => 'Tietoja minusta…';

  @override
  String get initial_setup_screen_profile_pictures_file_size_too_large_error =>
      'Kuva on liian suuri (enimmäiskoko on 10 MiB)';

  @override
  String get initial_setup_screen_profile_pictures_primary_image_face_not_detected =>
      'Kasvoja ei havaittu. Valitse kuva, jossa kasvosi näkyvät selkeästi.';

  @override
  String get initial_setup_screen_profile_pictures_primary_image_info_dialog_description =>
      'Vähintään yksi profiilikuva vaaditaan. Ensimmäisessä kuvassa täytyy näkyä kasvosi selkeästi, ja sen neliömäinen rajaus näytetään profiiliruudukoissa.';

  @override
  String get initial_setup_screen_profile_pictures_select_picture_dialog_title => 'Valitse kuva…';

  @override
  String get initial_setup_screen_profile_pictures_select_picture_from_gallery_title =>
      'Valitse galleriasta';

  @override
  String get initial_setup_screen_profile_pictures_select_picture_security_selfie_title =>
      'Käytä moderointiselfietä';

  @override
  String get initial_setup_screen_profile_pictures_select_picture_take_new_picture_title =>
      'Ota kuva';

  @override
  String get initial_setup_screen_profile_pictures_title => 'Profiilikuvani ovat…';

  @override
  String get initial_setup_screen_profile_pictures_unsupported_image_error =>
      'Ei-tuettu kuvamuoto. Valitse JPEG- tai PNG-kuva.';

  @override
  String get initial_setup_screen_profile_privacy_settings_title => 'Profiilin yksityisyys';

  @override
  String get initial_setup_screen_refresh_face_detected_values_action =>
      'Päivitä kasvojen tunnistuksen tila';

  @override
  String get initial_setup_screen_search_settings_max_age_subtitle => '…enimmäisikä…';

  @override
  String get initial_setup_screen_search_settings_min_age_subtitle => '…vähimmäisikä…';

  @override
  String get initial_setup_screen_search_settings_title => 'Etsin…';

  @override
  String get initial_setup_screen_security_selfie_description =>
      'Ota selfie etukamerallasi. Tätä selfietä käytetään profiilikuviesi vahvistamiseen ja se näkyy vain moderaattoreille, ellet lisää sitä profiiliisi myöhemmin.';

  @override
  String get initial_setup_screen_security_selfie_face_not_detected =>
      'Kasvoja ei havaittu. Yritä uudelleen selkeässä valaistuksessa tai ota yhteyttä tukeen.';

  @override
  String get initial_setup_screen_security_selfie_title => 'Moderointiselfieni on…';

  @override
  String get initial_setup_screen_skip_dialog_description =>
      'Ohita profiilin määritys vain, jos sinulla on ylläpitäjän oikeudet palveluun.';

  @override
  String get initial_setup_screen_skip_dialog_title => 'Ohitetaanko profiilin määritys?';

  @override
  String get likes_screen_like_loading_failed => 'Keskustelupyyntöjen lataus epäonnistui';

  @override
  String get likes_screen_no_received_likes_found => 'Ei keskustelupyyntöjä vielä';

  @override
  String get likes_screen_no_received_likes_found_description =>
      'Kerro sovelluksesta sosiaalisessa mediassa';

  @override
  String get likes_screen_refresh_action => 'Päivitä';

  @override
  String get likes_screen_title => 'Pyynnöt';

  @override
  String get login_screen_app_attestation_app_integrity_error =>
      'Sovelluksen eheystarkistus epäonnistui';

  @override
  String get login_screen_app_attestation_device_integrity_error =>
      'Laitteen eheystarkistus epäonnistui';

  @override
  String get login_screen_app_attestation_failed =>
      'Sovelluksen vahvistus epäonnistui. Yritä myöhemmin uudelleen.';

  @override
  String get login_screen_connecting_websocket_failed =>
      'Palvelimeen yhdistäminen epäonnistui. Yritä myöhemmin uudelleen.';

  @override
  String get login_screen_demo_account_dialog_description =>
      'Kirjaudu demotilille, joka sijaitsee demotilipalvelimella.';

  @override
  String get login_screen_demo_account_dialog_title => 'Demotilille kirjautuminen';

  @override
  String get login_screen_demo_account_login_failed => 'Kirjautuminen epäonnistui';

  @override
  String get login_screen_demo_account_login_session_expired => 'Demotilin istunto vanhentui';

  @override
  String get login_screen_demo_account_password => 'Salasana';

  @override
  String get login_screen_demo_account_username => 'Käyttäjätunnus';

  @override
  String get login_screen_email_already_used => 'Sähköpostiosoite on jo toisen tilin käytössä';

  @override
  String get login_screen_invalid_email_login_token => 'Virheellinen sähköpostikirjautumiskoodi';

  @override
  String get login_screen_ios_pwa_install_description =>
      'Käyttääksesi tätä sovellusta iOS:llä, lisää se Koti-valikkoon:';

  @override
  String get login_screen_ios_pwa_install_step1 => '1. Napauta \"Jaa\"-painiketta';

  @override
  String get login_screen_ios_pwa_install_step1_ios26 =>
      '1. Napauta \"Jaa\" tai avaa kolmen pisteen valikko löytääksesi sen';

  @override
  String get login_screen_ios_pwa_install_step2 =>
      '2. Vieritä alas ja napauta \"Lisää Koti-valikkoon\"';

  @override
  String get login_screen_ios_pwa_install_step2_ios26 =>
      '2. Napauta \"Katso lisää\" ja \"Lisää Koti-valikkoon\"';

  @override
  String get login_screen_ios_pwa_install_step3 => '3. Napauta \"Lisää\" oikeassa yläkulmassa';

  @override
  String get login_screen_ios_pwa_install_step4 => '4. Avaa sovellus Koti-valikosta';

  @override
  String get login_screen_ios_pwa_install_text_instructions_button => 'Tekstiohjeet';

  @override
  String get login_screen_ios_pwa_install_video_instructions_button => 'Video-ohjeet';

  @override
  String get login_screen_login_all_platforms_disabled =>
      'Kirjautuminen on tällä hetkellä pois käytöstä';

  @override
  String get login_screen_login_api_request_failed =>
      'Kirjautumispyyntö epäonnistui. Yritä myöhemmin uudelleen.';

  @override
  String get login_screen_login_note_text_and => 'ja';

  @override
  String get login_screen_login_note_text_beginning => 'Kirjautumalla sisään hyväksyt palvelumme';

  @override
  String get login_screen_login_note_text_privacy_policy => 'tietosuojaselosteen';

  @override
  String get login_screen_login_note_text_tos => 'käyttöehdot';

  @override
  String login_screen_login_platform_disabled(String p0) {
    return 'Kirjautuminen on tällä hetkellä pois käytöstä tällä alustalla ($p0)';
  }

  @override
  String get login_screen_registration_all_platforms_disabled =>
      'Uudet rekisteröitymiset ovat tällä hetkellä pois käytöstä';

  @override
  String login_screen_registration_platform_disabled(String p0) {
    return 'Uudet rekisteröitymiset ovat tällä hetkellä pois käytöstä tällä alustalla ($p0)';
  }

  @override
  String get login_screen_shared_computer_warning =>
      'Kirjaudu vain henkilökohtaisilla laitteilla. Jaetun tai julkisen tietokoneen käyttäminen vaarantaa yksityisyytesi.';

  @override
  String get login_screen_sign_in_with_email_action => 'Kirjaudu sähköpostilla';

  @override
  String get login_screen_sign_in_with_email_unverified => 'Sähköpostiosoitetta ei ole vahvistettu';

  @override
  String get login_screen_sign_in_with_error => 'Kirjautuminen epäonnistui';

  @override
  String get map_location_update_failed => 'Sijainnin päivitys epäonnistui';

  @override
  String get map_location_update_successful => 'Sijainti päivitetty';

  @override
  String get map_openstreetmap_data_attribution_link_text => 'OpenStreetMapin tekijät';

  @override
  String get map_select_location_help_text =>
      'Napauta tai paina kohtaa kartalla asettaaksesi sijaintisi.';

  @override
  String get map_tile_error => 'Kartan lataaminen epäonnistui';

  @override
  String get menu_screen_admin_offline_title =>
      'Automaattinen moderointi on tilapäisesti poissa käytöstä';

  @override
  String get menu_screen_help_center_title => 'Ohjekeskus';

  @override
  String get menu_screen_server_maintenance_title => 'Huoltokatko';

  @override
  String get menu_screen_title => 'Valikko';

  @override
  String moderation_rejected_category(String p0) {
    return 'Hylkäyskategoria: $p0';
  }

  @override
  String moderation_rejected_details(String p0) {
    return 'Hylkäyksen tiedot: $p0';
  }

  @override
  String moderation_state(String p0) {
    return 'Moderoinnin tila: $p0';
  }

  @override
  String get moderation_state_accepted => 'Hyväksytty';

  @override
  String get moderation_state_rejected_by_admin => 'Ylläpitäjä hylännyt';

  @override
  String get moderation_state_rejected_by_admin_bot => 'Ylläpitobotti hylännyt';

  @override
  String get moderation_state_waiting_admin => 'Odottaa ylläpitäjää';

  @override
  String get moderation_state_waiting_admin_bot => 'Odottaa ylläpitobottia';

  @override
  String get news_list_screen_create_new => 'Luo uusi?';

  @override
  String get news_list_screen_news_loading_failed => 'Uutisten lataus epäonnistui';

  @override
  String get news_list_screen_no_news_found => 'Ei uutisia saatavilla';

  @override
  String get news_list_screen_not_published => 'Luonnos';

  @override
  String get news_list_screen_title => 'Uutiset';

  @override
  String notification_automatic_profile_search_found_profiles_multiple(String p0) {
    return '$p0 uutta tai päivitettyä profiilia löytyi';
  }

  @override
  String get notification_automatic_profile_search_found_profiles_single =>
      'Uusi tai päivitetty profiili löytyi';

  @override
  String get notification_category_automatic_profile_search => 'Uudet ja päivitetyt profiilit';

  @override
  String get notification_category_group_chat => 'Keskustelu';

  @override
  String get notification_category_group_content_moderation => 'Sisällön moderointi';

  @override
  String get notification_category_group_general => 'Yleinen';

  @override
  String get notification_category_likes => 'Pyynnöt';

  @override
  String get notification_category_media_content_moderation_completed => 'Kuvat';

  @override
  String get notification_category_messages => 'Viestit';

  @override
  String get notification_category_news_item_available => 'Uutiset';

  @override
  String get notification_category_profile_string_moderation_completed =>
      'Profiilin nimi ja teksti';

  @override
  String get notification_like_received_multiple => 'Keskustelupyyntöjä vastaanotettu';

  @override
  String get notification_like_received_single => 'Keskustelupyyntö vastaanotettu';

  @override
  String get notification_media_content_accepted => 'Kuva hyväksytty';

  @override
  String get notification_media_content_deleted => 'Kuva poistettu';

  @override
  String get notification_media_content_deleted_description =>
      'Kuvassasi havaittiin kiellettyä sisältöä. Tämä saattaa olla väärä hälytys.';

  @override
  String get notification_media_content_rejected => 'Kuva hylätty';

  @override
  String notification_message_received_multiple(String p0) {
    return '$p0 lähetti viestejä';
  }

  @override
  String get notification_message_received_multiple_generic => 'Uusia viestejä vastaanotettu';

  @override
  String notification_message_received_single(String p0) {
    return '$p0 lähetti viestin';
  }

  @override
  String get notification_message_received_single_generic => 'Uusi viesti vastaanotettu';

  @override
  String get notification_news_item_available => 'Uutinen saatavilla';

  @override
  String get notification_permission_dialog_description =>
      'Salli ilmoitukset saadaksesi hälytyksiä esimerkiksi uusista keskustelupyynnöistä ja viesteistä.';

  @override
  String get notification_permission_dialog_title => 'Salli ilmoitukset?';

  @override
  String get notification_profile_name_accepted => 'Profiilinimi hyväksytty';

  @override
  String get notification_profile_name_rejected => 'Profiilinimi hylätty';

  @override
  String get notification_profile_text_accepted => 'Profiiliteksti hyväksytty';

  @override
  String get notification_profile_text_rejected => 'Profiiliteksti hylätty';

  @override
  String get notification_settings_screen_ios_pwa_permission_denied =>
      'Lupa evätty. Yritä uudelleen tai salli ilmoitukset iOS-asetuksista.';

  @override
  String
  get notification_settings_screen_notification_category_disabled_from_system_settings_text =>
      'Pois käytöstä järjestelmäasetuksista';

  @override
  String get notification_settings_screen_notifications_disabled_from_system_settings_text =>
      'Ilmoitukset on poistettu käytöstä järjestelmäasetuksista';

  @override
  String get notification_settings_screen_open_system_notification_settings =>
      'Järjestelmän ilmoitusasetukset';

  @override
  String get notification_settings_screen_title => 'Ilmoitukset';

  @override
  String get notification_settings_screen_web_permission_denied =>
      'Lupa evätty. Yritä uudelleen tai salli ilmoitukset selaimen asetuksista.';

  @override
  String get notification_settings_screen_web_permission_not_enabled =>
      'Ilmoitukset eivät ole käytössä';

  @override
  String get notification_settings_screen_web_request_permission => 'Ota ilmoitukset käyttöön';

  @override
  String get privacy_settings_last_seen_time => 'Nähty viimeksi -aika';

  @override
  String get privacy_settings_last_seen_time_disabled_description =>
      'Et näe, milloin toiset olivat viimeksi paikalla';

  @override
  String get privacy_settings_last_seen_time_enabled_description =>
      'Näytä, milloin olit viimeksi paikalla';

  @override
  String get privacy_settings_message_state_seen => 'Viestien lukukuittaukset';

  @override
  String get privacy_settings_message_state_seen_disabled_description => 'Et näe lukukuittauksia';

  @override
  String get privacy_settings_message_state_seen_enabled_description =>
      'Anna muiden nähdä, kun olet lukenut heidän viestinsä';

  @override
  String get privacy_settings_online_status => 'Paikallaolotila';

  @override
  String get privacy_settings_online_status_disabled_description =>
      'Et näe muiden paikallaolotilaa';

  @override
  String get privacy_settings_online_status_enabled_description => 'Näytä, milloin olet paikalla';

  @override
  String get privacy_settings_screen_chat_category => 'Keskustelu';

  @override
  String get privacy_settings_screen_profile_category => 'Profiili';

  @override
  String get privacy_settings_screen_title => 'Yksityisyys';

  @override
  String get privacy_settings_typing_indicator => 'Kirjoitusilmaisin';

  @override
  String get privacy_settings_typing_indicator_disabled_description =>
      'Et näe, kun toiset kirjoittavat';

  @override
  String get privacy_settings_typing_indicator_enabled_description =>
      'Anna muiden nähdä, kun kirjoitat';

  @override
  String get profile_filters_screen_disable_filters_action => 'Nollaa suodattimet';

  @override
  String get profile_filters_screen_disable_filters_action_dialog_title => 'Nollaa suodattimet?';

  @override
  String get profile_filters_screen_distance_filter => 'Etäisyys';

  @override
  String get profile_filters_screen_distance_filter_unit => 'km';

  @override
  String get profile_filters_screen_max_age_filter => 'Maksimi-ikä';

  @override
  String get profile_filters_screen_min_age_filter => 'Minimi-ikä';

  @override
  String get profile_filters_screen_profile_created_filter => 'Profiili luotu';

  @override
  String get profile_filters_screen_profile_edited_filter => 'Profiili muokattu';

  @override
  String get profile_filters_screen_profile_last_seen_time_filter => 'Nähty viimeksi';

  @override
  String get profile_filters_screen_profile_last_seen_time_filter_all => 'Milloin vain';

  @override
  String profile_filters_screen_profile_last_seen_time_filter_day(String p0) {
    return '$p0 päivä';
  }

  @override
  String profile_filters_screen_profile_last_seen_time_filter_days(String p0) {
    return '$p0 päivää';
  }

  @override
  String get profile_filters_screen_profile_last_seen_time_filter_disabled_from_privacy =>
      'Pois käytöstä yksityisyysasetuksista';

  @override
  String get profile_filters_screen_profile_last_seen_time_filter_online => 'Paikalla';

  @override
  String get profile_filters_screen_profile_text_filter => 'Profiilitekstin pituus';

  @override
  String get profile_filters_screen_profile_text_filter_unit => 'merkkiä';

  @override
  String get profile_filters_screen_profile_verification_requires_verified_account =>
      'Tämän suodattimen käyttö vaatii vahvistetun tilin';

  @override
  String get profile_filters_screen_profile_verification_status_filter => 'Profiilin vahvistus';

  @override
  String get profile_filters_screen_profile_verification_status_filter_face_verified =>
      'Kasvokuva vahvistettu moderointiselfiellä';

  @override
  String get profile_filters_screen_profile_verification_status_filter_profile_age_range_verified =>
      'Ikä (vahvistettu kerran)';

  @override
  String get profile_filters_screen_profile_verification_status_filter_profile_name_verified =>
      'Nimi';

  @override
  String get profile_filters_screen_title => 'Profiilisuodattimet';

  @override
  String get profile_filters_screen_unlimited_likes_filter => 'Treffiseuraa tälle päivälle';

  @override
  String profile_filters_screen_unsigned_integer_filter_max_value(String p0) {
    return 'Enintään $p0';
  }

  @override
  String profile_filters_screen_unsigned_integer_filter_max_value_with_unit(String p0, String p1) {
    return 'Enintään $p0 $p1';
  }

  @override
  String profile_filters_screen_unsigned_integer_filter_min_and_max_value(String p0, String p1) {
    return '$p0-$p1';
  }

  @override
  String profile_filters_screen_unsigned_integer_filter_min_and_max_value_with_unit(
    String p0,
    String p1,
    String p2,
  ) {
    return '$p0-$p1 $p2';
  }

  @override
  String profile_filters_screen_unsigned_integer_filter_min_value(String p0) {
    return 'Vähintään $p0';
  }

  @override
  String profile_filters_screen_unsigned_integer_filter_min_value_with_unit(String p0, String p1) {
    return 'Vähintään $p0 $p1';
  }

  @override
  String get profile_filters_screen_updating_filters_failed => 'Suodattimien päivitys epäonnistui';

  @override
  String get profile_grid_screen_account_verification_banner_button => 'Vahvista nyt';

  @override
  String get profile_grid_screen_account_verification_banner_text => 'Tiliäsi ei ole vahvistettu';

  @override
  String get profile_grid_screen_account_verification_banner_text_incomplete =>
      'Tilin vahvistus on keskeneräinen';

  @override
  String profile_grid_screen_daily_likes_dialog_text(String p0, String p1) {
    return 'Päivittäisiä keskustelupyyntöjä jäljellä: $p0\nNollaantumisaika: $p1';
  }

  @override
  String get profile_grid_screen_daily_likes_dialog_unlimited_likes_text =>
      'Keskustelupyyntöjen lähettäminen treffiseuraa tälle päivälle etsiville ei vähennä päivittäisiä keskustelupyyntöjä.';

  @override
  String get profile_grid_screen_email_not_verified =>
      'Vahvista sähköpostiosoitteesi. Vahvistuslinkki on lähetetty sähköpostiisi. Jos et löydä sitä, tarkista roskapostikansio.';

  @override
  String get profile_grid_screen_email_not_verified_button => 'Tilin asetukset';

  @override
  String get profile_grid_screen_filtering_favorite_profiles_is_not_supported =>
      'Suosikkien suodattamista ei tueta';

  @override
  String get profile_grid_screen_no_favorite_profiles_found_description =>
      'Merkitse profiili tähdellä tallentaaksesi sen tänne';

  @override
  String get profile_grid_screen_no_favorite_profiles_found_title => 'Ei suosikkeja vielä';

  @override
  String get profile_grid_screen_no_profiles_found_description_filters_disabled =>
      'Kerro sovelluksesta sosiaalisessa mediassa';

  @override
  String get profile_grid_screen_no_profiles_found_description_filters_enabled =>
      'Kokeile muokata tai nollata suodattimia';

  @override
  String get profile_grid_screen_no_profiles_found_title => 'Profiileja ei löytynyt';

  @override
  String get profile_grid_screen_primary_profile_content_does_not_exist =>
      'Ensimmäinen profiilikuva puuttuu';

  @override
  String get profile_grid_screen_primary_profile_content_face_not_detected =>
      'Kasvoja ei havaittu ensimmäisessä profiilikuvassa';

  @override
  String get profile_grid_screen_primary_profile_content_is_in_moderation =>
      'Voit selata ja näkyä muille, kun ensimmäinen profiilikuvasi on hyväksytty';

  @override
  String get profile_grid_screen_primary_profile_content_is_not_accepted =>
      'Ensimmäistä profiilikuvaa ei ole hyväksytty';

  @override
  String get profile_grid_screen_profile_filter_settings_update_ongoing =>
      'Päivitetään suodattimia…';

  @override
  String get profile_grid_screen_profile_is_private_info =>
      'Selataksesi profiileja, aseta profiilisi julkiseksi Asetuksista.';

  @override
  String get profile_grid_screen_security_content_does_not_exist => 'Moderointiselfie puuttuu';

  @override
  String get profile_grid_screen_security_content_face_not_detected =>
      'Kasvoja ei havaittu moderointiselfiessä';

  @override
  String get profile_grid_screen_security_content_is_not_accepted =>
      'Moderointiselfietä ei ole hyväksytty';

  @override
  String profile_grid_screen_selected_age_range(String p0) {
    return 'Valittu ikähaarukka: $p0';
  }

  @override
  String get profile_grid_screen_show_all_profiles_action => 'Näytä kaikki profiilit';

  @override
  String get profile_grid_screen_show_favorite_profiles_action => 'Näytä suosikit';

  @override
  String get profile_grid_screen_start_initial_setup_button => 'Määritä profiili';

  @override
  String get profile_grid_screen_title => 'Profiilit';

  @override
  String get profile_grid_settings_screen_all_grids_title => 'Kaikki profiiliruudukot';

  @override
  String get profile_grid_settings_screen_image_quality_high => 'Korkea';

  @override
  String get profile_grid_settings_screen_image_quality_low => 'Matala';

  @override
  String get profile_grid_settings_screen_image_quality_lower => 'Matalampi';

  @override
  String get profile_grid_settings_screen_image_quality_medium => 'Keskitaso';

  @override
  String get profile_grid_settings_screen_image_quality_very_low => 'Erittäin matala';

  @override
  String get profile_grid_settings_screen_images_title => 'Kuvat';

  @override
  String get profile_grid_settings_screen_preferred_image_quality => 'Ensisijainen kuvanlaatu';

  @override
  String get profile_grid_settings_screen_profiles_screen => 'Profiilit-näkymä';

  @override
  String get profile_grid_settings_screen_random_profile_order => 'Satunnainen profiilijärjestys';

  @override
  String get profile_grid_settings_screen_random_profile_order_description_disabled =>
      'Aloita sijainnistasi';

  @override
  String get profile_grid_settings_screen_random_profile_order_description_enabled =>
      'Aloita satunnaisesta sijainnista';

  @override
  String get profile_grid_settings_screen_title => 'Profiiliruudukko';

  @override
  String get profile_image_error_image_not_accepted => 'Profiilikuvaa ei ole hyväksytty';

  @override
  String get profile_image_error_no_image => 'Ei profiilikuvaa';

  @override
  String get profile_image_error_no_primary_image => 'Ensisijainen profiilikuva puuttuu';

  @override
  String get profile_location_screen_title => 'Sijainti';

  @override
  String get profile_statistics_history_screen_title => 'Profiilitilastojen historia';

  @override
  String get receive_chat_backup_import_success => 'Varmuuskopio tuotu onnistuneesti';

  @override
  String get receive_chat_backup_importing => 'Tuodaan varmuuskopiota…';

  @override
  String get receive_chat_backup_pairing_code_instruction => 'Toisella laitteella:';

  @override
  String receive_chat_backup_pairing_code_step1(String p0) {
    return '1. Avaa $p0';
  }

  @override
  String get receive_chat_backup_pairing_code_step2 =>
      '2. Kirjaudu ulos Asetuksista, jos kirjautumisnäkymä ei ole näkyvissä';

  @override
  String get receive_chat_backup_pairing_code_step3 => '3. Napauta valikkoa oikeassa yläkulmassa';

  @override
  String get receive_chat_backup_pairing_code_step4 => '4. Valitse Lähetä keskusteluvarmuuskopio';

  @override
  String get receive_chat_backup_pairing_code_step5 =>
      '5. Skannaa tämä QR-koodi aloittaaksesi siirron';

  @override
  String get receive_chat_backup_screen_title => 'Vastaanota keskusteluvarmuuskopio';

  @override
  String get receive_chat_backup_show_qr_code => 'Näytä QR-koodi';

  @override
  String get receive_chat_backup_show_text_code => 'Näytä tekstikoodi';

  @override
  String get receive_chat_backup_transferring => 'Vastaanotetaan varmuuskopiota…';

  @override
  String get receive_chat_backup_waiting_for_source => 'Odotetaan toista laitetta…';

  @override
  String report_chat_message_screen_selection_status_count(String p0, String p1) {
    return '$p0/$p1 viestiä valittu';
  }

  @override
  String get report_chat_message_screen_selection_status_none => 'Valitse enintään 10 viestiä';

  @override
  String get report_chat_message_screen_server_signed_message_not_found =>
      'Palvelimen allekirjoittamaa viestiä ei löytynyt';

  @override
  String get report_chat_message_screen_symmetric_message_encryption_key_not_found =>
      'Symmetristä viestinsalausavainta ei löytynyt';

  @override
  String get report_profile_image_screen_confirm_dialog_title => 'Ilmoita profiilikuva?';

  @override
  String report_profile_image_screen_image_title(String p0) {
    return 'Profiilikuva $p0';
  }

  @override
  String get report_profile_image_screen_profile_image_changed_error =>
      'Ilmoitus epäonnistui: profiilikuva on muuttunut';

  @override
  String get report_screen_chat_message_action => 'Chat-viesti';

  @override
  String report_screen_custom_report_boolean_dialog_description(String p0) {
    return 'Ilmoita käyttäjästä syyllä $p0?';
  }

  @override
  String get report_screen_false_reports_warning =>
      'Väärien ilmoitusten tekeminen voi johtaa tilin porttikieltoon';

  @override
  String get report_screen_profile_image_action => 'Profiilikuva';

  @override
  String get report_screen_profile_name_action => 'Profiilinimi';

  @override
  String get report_screen_profile_name_changed_error =>
      'Ilmoitus epäonnistui: profiilinimi on muuttunut';

  @override
  String get report_screen_profile_name_dialog_title => 'Ilmoita profiilinimi?';

  @override
  String get report_screen_profile_text_action => 'Profiiliteksti';

  @override
  String get report_screen_profile_text_changed_error =>
      'Ilmoitus epäonnistui: profiiliteksti on muuttunut';

  @override
  String get report_screen_profile_text_dialog_title => 'Ilmoita profiiliteksti?';

  @override
  String get report_screen_snackbar_report_successful => 'Ilmoitus lähetetty';

  @override
  String get report_screen_snackbar_too_many_reports_error =>
      'Liian monta ilmoitusta lähetetty. Yritä myöhemmin uudelleen.';

  @override
  String get scan_pairing_code_instruction => 'Osoita kamera QR-koodiin';

  @override
  String get scan_pairing_code_screen_title => 'Skannaa QR-koodi';

  @override
  String get search_settings_screen_automatic_search => 'Uudet ja päivitetyt profiilit';

  @override
  String get search_settings_screen_change_gender_filter_action_tile => 'Sukupuolisuodatin';

  @override
  String get search_settings_screen_change_my_gender_action_title => 'Muuta profiilini sukupuoli';

  @override
  String get search_settings_screen_distance => 'Käytä maksimietäisyyssuodatinta';

  @override
  String get search_settings_screen_filters => 'Käytä monivalintakysymyssuodattimia';

  @override
  String get search_settings_screen_gender_filter_is_not_selected =>
      'Sukupuolisuodatinta ei ole valittu';

  @override
  String get search_settings_screen_gender_is_not_selected => 'Sukupuoltasi ei ole asetettu';

  @override
  String get search_settings_screen_new_profiles => 'Piilota päivitetyt profiilit';

  @override
  String get search_settings_screen_search_settings_update_failed =>
      'Hakuasetusten päivitys epäonnistui';

  @override
  String get search_settings_screen_title => 'Profiilihaku';

  @override
  String get search_settings_screen_weekdays => 'Hakupäivät';

  @override
  String select_content_screen_count(String p0, String p1) {
    return 'Kuvia $p0/$p1';
  }

  @override
  String get select_content_screen_face_detected => 'Kasvot havaittu';

  @override
  String get select_content_screen_title => 'Valitse kuva';

  @override
  String get select_match_screen_title => 'Hyväksytyt keskustelupyynnöt';

  @override
  String get send_chat_backup_creating_backup => 'Luodaan varmuuskopiota…';

  @override
  String get send_chat_backup_idle => 'Valmis lähettämään varmuuskopio';

  @override
  String get send_chat_backup_pairing_code_hint => 'Syötä parituskoodi vastaanottavasta laitteesta';

  @override
  String get send_chat_backup_scan_qr_button => 'Skannaa QR-koodi';

  @override
  String get send_chat_backup_screen_title => 'Lähetä keskusteluvarmuuskopio';

  @override
  String get send_chat_backup_send_another_button => 'Lähetä toinen varmuuskopio';

  @override
  String get send_chat_backup_start_button => 'Aloita siirto';

  @override
  String get send_chat_backup_success => 'Varmuuskopio lähetetty onnistuneesti';

  @override
  String get send_chat_backup_transferring => 'Lähetetään varmuuskopiota…';

  @override
  String get send_chat_backup_use_text_code_button => 'Käytä tekstikoodia';

  @override
  String get server_connection_indicator_connection_failed => 'Yhteys epäonnistui';

  @override
  String get server_connection_indicator_connection_failed_dialog_text =>
      'Yhteyttä palvelimeen ei saatu. Tarkista internetyhteytesi ja yritä myöhemmin uudelleen. Jos ongelma jatkuu, palvelin saattaa olla tilapäisesti poissa käytöstä.';

  @override
  String server_connection_indicator_reconnecting_in_seconds(String p0) {
    return 'Yhdistetään uudelleen $p0 sekunnin kuluttua';
  }

  @override
  String server_connection_indicator_websocket_attempts_remaining_today(String p0) {
    return 'Sinulla on $p0 yhdistämisyritystä jäljellä (nollautuu päivittäin)';
  }

  @override
  String get server_connection_indicator_websocket_daily_limit_reached =>
      'Liian monta yhdistämisyritystä tänään. Yritä huomenna uudelleen.';

  @override
  String get settings_screen_data_category => 'Tiedot';

  @override
  String get settings_screen_general_category => 'Yleiset';

  @override
  String get settings_screen_privacy_and_security_category => 'Yksityisyys ja turvallisuus';

  @override
  String get settings_screen_profile_category => 'Profiili';

  @override
  String get settings_screen_profile_visibility_private_description =>
      'Piilota profiilisi Profiilit-näkymästä';

  @override
  String get settings_screen_profile_visibility_public_description =>
      'Näytä profiilisi Profiilit-näkymässä';

  @override
  String get settings_screen_profile_visibility_setting => 'Profiilin näkyvyys';

  @override
  String get settings_screen_title => 'Asetukset';

  @override
  String get sign_in_with_management_screen_apple_not_linked =>
      'Linkitä Apple-tilisi kirjautuaksesi sillä';

  @override
  String get sign_in_with_management_screen_apple_title => 'Kirjaudu Applella';

  @override
  String get sign_in_with_management_screen_apple_unlink_confirm_title =>
      'Poistetaanko Apple-tilin linkitys?';

  @override
  String get sign_in_with_management_screen_email_login_disable_confirm_title =>
      'Poistetaanko sähköpostikirjautuminen käytöstä?';

  @override
  String get sign_in_with_management_screen_email_login_disabled =>
      'Sähköpostikirjautuminen on pois käytöstä';

  @override
  String get sign_in_with_management_screen_email_login_enable_confirm_title =>
      'Otetaanko sähköpostikirjautuminen käyttöön?';

  @override
  String get sign_in_with_management_screen_email_login_enabled =>
      'Sähköpostikirjautuminen on käytössä';

  @override
  String get sign_in_with_management_screen_email_login_title => 'Sähköpostikirjautuminen';

  @override
  String get sign_in_with_management_screen_google_not_linked =>
      'Linkitä Google-tilisi kirjautuaksesi sillä';

  @override
  String get sign_in_with_management_screen_google_title => 'Kirjaudu Googlella';

  @override
  String get sign_in_with_management_screen_google_unlink_confirm_title =>
      'Poistetaanko Google-tilin linkitys?';

  @override
  String get sign_in_with_management_screen_link_failed => 'Kirjautumistavan linkitys epäonnistui';

  @override
  String sign_in_with_management_screen_link_history_limit_reached(String p0) {
    return 'Kirjautumistavan vaihtoraja saavutettu. Yritä uudelleen $p0 kuluttua.';
  }

  @override
  String get sign_in_with_management_screen_local_auth_reason =>
      'Vahvista henkilöllisyytesi hallitaksesi kirjautumistapoja';

  @override
  String get sign_in_with_management_screen_title => 'Kirjautumistavat';

  @override
  String get sign_in_with_management_screen_unlink_failed =>
      'Kirjautumistavan linkityksen poisto epäonnistui';

  @override
  String get snackbar_api_forbidden_request => 'Toiminto ei ole sallittu';

  @override
  String get snackbar_api_usage_limit_reached =>
      'Päivittäinen raja saavutettu. Yritä huomenna uudelleen.';

  @override
  String get snackbar_error_api => 'API-pyyntö epäonnistui';

  @override
  String get snackbar_error_api_timeout => 'API-pyyntö aikakatkaistiin';

  @override
  String get snackbar_error_database => 'Tietokantavirhe';

  @override
  String get snackbar_error_file => 'Tiedostovirhe';

  @override
  String get snackbar_error_logic => 'Odottamaton virhe';

  @override
  String get snackbar_image_quality_degraded =>
      'Monet käyttäjät selaavat profiileja - kuvanlaatu voi olla tilapäisesti heikentynyt';

  @override
  String snackbar_play_integrity_api_error(String p0) {
    return 'Sovelluksen vahvistusvirhe: $p0';
  }

  @override
  String get splash_screen_app_is_already_running =>
      'Sovellus on jo käynnissä toisessa ikkunassa. Sulje toinen sovellusinstanssi ja varmista, ettei sovellusta ole auki missään selainikkunassa tai -välilehdessä.';

  @override
  String get splash_screen_app_version_downgrade_detected =>
      'Varoitus: Sovellusversion vanhentuminen havaittu. Käytä uusinta versiota.';

  @override
  String statistics_screen_age_range(String p0) {
    return 'Iät: $p0';
  }

  @override
  String statistics_screen_count_all_profiles(String p0) {
    return 'Kaikki profiilit: $p0';
  }

  @override
  String statistics_screen_count_men(String p0) {
    return 'Miehet: $p0';
  }

  @override
  String statistics_screen_count_nonbinaries(String p0) {
    return 'Muunsukupuoliset: $p0';
  }

  @override
  String statistics_screen_count_online_users(String p0) {
    return 'Paikalla olevat käyttäjät: $p0';
  }

  @override
  String statistics_screen_count_online_users_bar_chart_tooltip(String p0) {
    return 'Paikalla: $p0';
  }

  @override
  String statistics_screen_count_private_profiles(String p0) {
    return 'Yksityiset profiilit: $p0';
  }

  @override
  String statistics_screen_count_public_profiles(String p0) {
    return 'Julkiset profiilit: $p0';
  }

  @override
  String statistics_screen_count_registered_users(String p0) {
    return 'Rekisteröityneet käyttäjät: $p0';
  }

  @override
  String statistics_screen_count_women(String p0) {
    return 'Naiset: $p0';
  }

  @override
  String statistics_screen_hour_value(String p0) {
    return 'Tunti: $p0';
  }

  @override
  String get statistics_screen_online_users_per_hour_statistics_title =>
      'Paikalla olevat käyttäjät tunneittain';

  @override
  String statistics_screen_time(String p0) {
    return 'Aika: $p0';
  }

  @override
  String get statistics_screen_title => 'Tilastot';

  @override
  String get unsupported_client_screen_info =>
      'Tätä sovellusversiota ei enää tueta. Päivitä uusimpaan versioon.';

  @override
  String get unsupported_client_screen_title => 'Sovelluspäivitys vaaditaan';

  @override
  String get url_app_privacy_policy_link => 'https://example.com';

  @override
  String get url_app_tos_link => 'https://example.com';

  @override
  String get verification_error_data_parsing_failed => 'Virheelliset tunnistautumistiedot';

  @override
  String get verification_error_data_verification_failed =>
      'Henkilöllisyyden vahvistus epäonnistui';

  @override
  String get verification_error_method_not_configured =>
      'Sovelluksen ylläpitäjä ei ole määrittänyt tätä vahvistustapaa';

  @override
  String get verification_method_eudi_unsupported => 'EUDI-lompakko (ei tuettu tässä versiossa)';

  @override
  String get video_call_tip_dialog_description =>
      'Voit lähettää videopuhelukutsun keskustelun oikeassa yläkulmassa olevasta videopuhelukuvakkeesta.';

  @override
  String get video_call_tip_dialog_title => 'Pidätkö videopuheluista?';

  @override
  String get view_image_screen_title => 'Kuva';

  @override
  String view_news_screen_edited(String p0) {
    return 'Muokattu: $p0';
  }

  @override
  String view_news_screen_published(String p0) {
    return 'Julkaistu: $p0';
  }

  @override
  String get view_profile_screen_add_to_favorites_action => 'Lisää suosikkeihin';

  @override
  String get view_profile_screen_add_to_favorites_action_successful => 'Lisätty suosikkeihin';

  @override
  String get view_profile_screen_add_to_favorites_error_too_many_favorites =>
      'Suosikkilista on täysi';

  @override
  String view_profile_screen_add_to_favorites_remaining_space(String p0) {
    return 'Jäljellä olevat suosikkipaikat: $p0';
  }

  @override
  String get view_profile_screen_already_match => 'Keskustelu on jo mahdollista';

  @override
  String get view_profile_screen_block_action => 'Estä';

  @override
  String get view_profile_screen_block_action_dialog_title => 'Estä profiili?';

  @override
  String get view_profile_screen_block_action_successful => 'Profiili estetty';

  @override
  String get view_profile_screen_chat_action => 'Keskustele';

  @override
  String get view_profile_screen_like_action => 'Lähetä keskustelupyyntö';

  @override
  String get view_profile_screen_like_action_dialog_title => 'Lähetä keskustelupyyntö?';

  @override
  String get view_profile_screen_like_action_like_already_received =>
      'Keskustelupyyntö on jo vastaanotettu';

  @override
  String get view_profile_screen_like_action_like_already_sent =>
      'Keskustelupyyntö on jo lähetetty';

  @override
  String get view_profile_screen_like_action_successful => 'Keskustelupyyntö lähetetty';

  @override
  String get view_profile_screen_like_action_try_again_tomorrow =>
      'Päivittäiset keskustelupyynnöt ovat jo käytetty. Yritä huomenna uudelleen.';

  @override
  String get view_profile_screen_my_profile_edit_action => 'Muokkaa profiilia';

  @override
  String get view_profile_screen_my_profile_initial_setup_not_done =>
      'Profiilia ei ole vielä määritetty';

  @override
  String get view_profile_screen_my_profile_title => 'Oma profiili';

  @override
  String get view_profile_screen_non_accepted_profile_content_info_dialog_text =>
      'Kaikkia profiilikuvia ei ole vielä moderoitu tai jokin kuva on hylätty. Vain hyväksytyt kuvat näkyvät käyttäjille.';

  @override
  String view_profile_screen_non_accepted_profile_content_info_dialog_text_picture_title(
    String p0,
  ) {
    return 'Kuva $p0';
  }

  @override
  String get view_profile_screen_non_accepted_profile_name_info_dialog_text =>
      'Profiilinimeä ei ole vielä moderoitu tai se on hylätty. Vain ensimmäinen kirjain näkyy käyttäjille.';

  @override
  String get view_profile_screen_non_accepted_profile_text_info_dialog_text =>
      'Profiilitekstiä ei ole vielä moderoitu tai se on hylätty. Vain ensimmäinen kirjain näkyy käyttäjille.';

  @override
  String get view_profile_screen_profile_currently_online => 'Paikalla';

  @override
  String get view_profile_screen_profile_edit_failed => 'Profiilin tallennus epäonnistui';

  @override
  String view_profile_screen_profile_image_does_not_exist(String p0) {
    return 'Profiilikuva $p0 ei ole olemassa';
  }

  @override
  String view_profile_screen_profile_last_seen_day(String p0) {
    return 'Nähty $p0 päivä sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_days(String p0) {
    return 'Nähty $p0 päivää sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_hour(String p0) {
    return 'Nähty $p0 tunti sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_hours(String p0) {
    return 'Nähty $p0 tuntia sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_minute(String p0) {
    return 'Nähty $p0 minuutti sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_minutes(String p0) {
    return 'Nähty $p0 minuuttia sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_second(String p0) {
    return 'Nähty $p0 sekunti sitten';
  }

  @override
  String view_profile_screen_profile_last_seen_seconds(String p0) {
    return 'Nähty $p0 sekuntia sitten';
  }

  @override
  String get view_profile_screen_profile_verification_requires_verified_account =>
      'Tämän tiedon katselu vaatii vahvistetun tilin';

  @override
  String get view_profile_screen_remove_from_favorites_action => 'Poista suosikeista';

  @override
  String get view_profile_screen_remove_from_favorites_action_successful => 'Poistettu suosikeista';
}
