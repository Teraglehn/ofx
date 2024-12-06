import 'dart:convert';

import 'package:test/test.dart';
import 'package:ofx/src/dto/ofx.dart';
import 'package:ofx/src/models/financial_institution.dart';
import 'package:ofx/src/models/status.dart';
import 'package:ofx/src/models/transaction.dart';

void main() {
  group('Ofx', () {
    test('should create an instance from a map', () {
      final map = {
        'status_ofx': {'code': 0, 'severity': 'INFO'},
        'server': DateTime.now().millisecondsSinceEpoch,
        'server_local': DateTime.now().millisecondsSinceEpoch,
        'language': 'ENG',
        'financial_institution': {'organization': 'Bank'},
        'transaction_unique_id': '12345',
        'status_transaction': {'code': 0, 'severity': 'INFO'},
        'currency': 'USD',
        'bank_id': '001',
        'account_id': '123456789',
        'account_type': 'CHECKING',
        'start': DateTime.now().millisecondsSinceEpoch,
        'start_local': DateTime.now().millisecondsSinceEpoch,
        'end': DateTime.now().millisecondsSinceEpoch,
        'end_local': DateTime.now().millisecondsSinceEpoch,
        'transactions': [
          {
            'type': 'DEBIT',
            'posted': DateTime.now().millisecondsSinceEpoch,
            'posted_local': DateTime.now().millisecondsSinceEpoch,
            'financialInstitutionID': '001',
            'amount': 100.0,
            'referenceNumber': '123',
            'memo': 'Transaction 1',
          }
        ],
      };

      final ofx = Ofx.fromMap(map);

      expect(ofx.statusOfx.code, 0, reason: 'statusOfx.code');
      expect(ofx.language, 'ENG', reason: 'language');
      expect(ofx.financialInstitution.organization, 'Bank',
          reason: 'financialInstitution.organization');
      expect(ofx.transactionUniqueID, '12345', reason: 'transactionUniqueID');
      expect(ofx.currency, 'USD', reason: 'currency');
      expect(ofx.bankID, '001', reason: 'bankID');
      expect(ofx.accountID, '123456789', reason: 'accountID');
      expect(ofx.accountType, 'CHECKING', reason: 'accountType');
      expect(ofx.transactions.length, 1, reason: 'transactions.length');
    });

    test('should convert an instance to a map', () {
      final ofx = Ofx(
        statusOfx: Status(code: 0, severity: 'INFO'),
        server: DateTime.now(),
        serverLocal: DateTime.now(),
        language: 'ENG',
        financialInstitution: FinancialInstitution(
            organization: 'Bank', financialInstitutionID: '001'),
        transactionUniqueID: '12345',
        statusTransaction: Status(code: 0, severity: 'INFO'),
        currency: 'USD',
        bankID: '001',
        accountID: '123456789',
        accountType: 'CHECKING',
        start: DateTime.now(),
        startLocal: DateTime.now(),
        end: DateTime.now(),
        endLocal: DateTime.now(),
        transactions: [
          Transaction(
            type: 'DEBIT',
            posted: DateTime.now(),
            postedLocal: DateTime.now(),
            financialInstitutionID: '001',
            amount: 100.0,
            referenceNumber: '123',
            memo: 'Transaction 1',
          )
        ],
      );

      final map = ofx.toMap();

      expect(map['status_ofx']['code'], 0);
      expect(map['language'], 'ENG');
      expect(map['financial_institution']['organization'], 'Bank');
      expect(map['transaction_unique_id'], '12345');
      expect(map['currency'], 'USD');
      expect(map['bank_id'], '001');
      expect(map['account_id'], '123456789');
      expect(map['account_type'], 'CHECKING');
      expect((map['transactions'] as List).length, 1);
    });

    test('should create an instance from JSON', () {
      final jsonString = '''
        {
          "status_ofx": {"code": 0, "severity": "INFO"},
          "server": ${DateTime.now().millisecondsSinceEpoch},
          "server_local": ${DateTime.now().millisecondsSinceEpoch},
          "language": "ENG",
          "financial_institution": {"organization": "Bank"},
          "transaction_unique_id": "12345",
          "status_transaction": {"code": 0, "severity": "INFO"},
          "currency": "USD",
          "bank_id": "001",
          "account_id": "123456789",
          "account_type": "CHECKING",
          "start": ${DateTime.now().millisecondsSinceEpoch},
          "start_local": ${DateTime.now().millisecondsSinceEpoch},
          "end": ${DateTime.now().millisecondsSinceEpoch},
          "end_local": ${DateTime.now().millisecondsSinceEpoch},
          "transactions": [
            {
              "type": "DEBIT",
              "posted": ${DateTime.now().millisecondsSinceEpoch},
              "posted_local": ${DateTime.now().millisecondsSinceEpoch},
              "financial_institution_id": "001",
              "amount": 100.0,
              "reference_number": "123",
              "memo": "Transaction 1"
            }
          ]
        }
        ''';

      final ofx = Ofx.fromJson(jsonString);

      expect(ofx.statusOfx.code, 0);
      expect(ofx.language, 'ENG');
      expect(ofx.financialInstitution.organization, 'Bank');
      expect(ofx.transactionUniqueID, '12345');
      expect(ofx.currency, 'USD');
      expect(ofx.bankID, '001');
      expect(ofx.accountID, '123456789');
      expect(ofx.accountType, 'CHECKING');
      expect(ofx.transactions.length, 1);
    });

    test('should convert an instance to JSON', () {
      final ofx = Ofx(
        statusOfx: Status(code: 0, severity: 'INFO'),
        server: DateTime.now(),
        serverLocal: DateTime.now(),
        language: 'ENG',
        financialInstitution: FinancialInstitution(
            organization: 'Bank', financialInstitutionID: '001'),
        transactionUniqueID: '12345',
        statusTransaction: Status(code: 0, severity: 'INFO'),
        currency: 'USD',
        bankID: '001',
        accountID: '123456789',
        accountType: 'CHECKING',
        start: DateTime.now(),
        startLocal: DateTime.now(),
        end: DateTime.now(),
        endLocal: DateTime.now(),
        transactions: [
          Transaction(
            type: 'DEBIT',
            posted: DateTime.now(),
            postedLocal: DateTime.now(),
            financialInstitutionID: '001',
            amount: 100.0,
            referenceNumber: '123',
            memo: 'Transaction 1',
          )
        ],
      );

      final jsonString = ofx.toJson();

      final map = json.decode(jsonString);

      expect(map['status_ofx']['code'], 0);
      expect(map['language'], 'ENG');
      expect(map['financial_institution']['organization'], 'Bank');
      expect(map['transaction_unique_id'], '12345');
      expect(map['currency'], 'USD');
      expect(map['bank_id'], '001');
      expect(map['account_id'], '123456789');
      expect(map['account_type'], 'CHECKING');
      expect((map['transactions'] as List).length, 1);
    });

    test('should convert from a xml string', () {
      final xmlString = '''
        <?xml version="1.0" encoding="utf-8"?>
        <?OFX OFXHEADER="200" VERSION="220" SECURITY="NONE" OLDFILEUID="NONE" NEWFILEUID="NONE" ?>

        <OFX>
          <SIGNONMSGSRSV1>
          <SONRS>
            <STATUS>
            <CODE>0</CODE>
            <SEVERITY>INFO</SEVERITY>
            </STATUS>
            <DTSERVER>20240510</DTSERVER>
            <LANGUAGE>ENG</LANGUAGE>
            <FI>
            <ORG>Bank</ORG>
            </FI>
          </SONRS>
          </SIGNONMSGSRSV1>
          <BANKMSGSRSV1>
          <STMTTRNRS>
            <TRNUID>12345</TRNUID>
            <STATUS>
            <CODE>0</CODE>
            <SEVERITY>INFO</SEVERITY>
            </STATUS>
            <STMTRS>
            <CURDEF>USD</CURDEF>
            <BANKACCTFROM>
              <BANKID>001</BANKID>
              <ACCTID>123456789</ACCTID>
              <ACCTTYPE>CHECKING</ACCTTYPE>
            </BANKACCTFROM>
            <BANKTRANLIST>
              <DTSTART>20240511</DTSTART>
              <DTEND>20240513</DTEND>
              <STMTTRN>
                <TRNTYPE>DEBIT</TRNTYPE>
                <DTPOSTED>20240512155500</DTPOSTED>
                <TRNAMT>100.0</TRNAMT>
                <FITID>123</FITID>
                <REFNUM>456</REFNUM>
                <MEMO>Transaction 1</MEMO>
              </STMTTRN>
              <STMTTRN>
                <TRNTYPE>DEBIT</TRNTYPE>
                <DTPOSTED>20240512135500</DTPOSTED>
                <TRNAMT>150.0</TRNAMT>
                <FITID>123</FITID>
                <MEMO>Transaction 2</MEMO>
              </STMTTRN>
            </BANKTRANLIST>
            </STMTRS>
          </STMTTRNRS>
          </BANKMSGSRSV1>
        </OFX>
        ''';

      final ofx = Ofx.fromString(xmlString);

      expect(ofx.statusOfx.code, 0);
      expect(ofx.language, 'ENG');
      expect(ofx.financialInstitution.organization, 'Bank');
      expect(ofx.transactionUniqueID, '12345');
      expect(ofx.start, DateTime.utc(2024, 5, 11));
      expect(ofx.end, DateTime.utc(2024, 5, 13));
      expect(ofx.currency, 'USD');
      expect(ofx.bankID, '001');
      expect(ofx.accountID, '123456789');
      expect(ofx.accountType, 'CHECKING');
      expect(ofx.transactions.length, 2);
      expect(ofx.transactions.first.type, 'DEBIT');
      expect(ofx.transactions.first.amount, 100.0);
      expect(ofx.transactions.first.financialInstitutionID, '123');
      expect(ofx.transactions.first.referenceNumber, '456');
      expect(ofx.transactions.first.memo, 'Transaction 1');
      expect(ofx.transactions.first.posted, DateTime.utc(2024, 5, 12, 15, 55));
    });

    test('should convert from a xml string without signon', () {
      final xmlString = '''
        <?xml version="1.0" encoding="utf-8"?>
        <?OFX OFXHEADER="200" VERSION="220" SECURITY="NONE" OLDFILEUID="NONE" NEWFILEUID="NONE" ?>

        <OFX>
          <BANKMSGSRSV1>
          <STMTTRNRS>
            <TRNUID>12345</TRNUID>
            <STATUS>
            <CODE>0</CODE>
            <SEVERITY>INFO</SEVERITY>
            </STATUS>
            <STMTRS>
            <CURDEF>USD</CURDEF>
            <BANKACCTFROM>
              <BANKID>001</BANKID>
              <ACCTID>123456789</ACCTID>
              <ACCTTYPE>CHECKING</ACCTTYPE>
            </BANKACCTFROM>
            <BANKTRANLIST>
              <DTSTART>20240510</DTSTART>
              <DTEND>20240512</DTEND>
              <STMTTRN>
                <TRNTYPE>DEBIT</TRNTYPE>
                <DTPOSTED>20240511103000</DTPOSTED>
                <TRNAMT>100.0</TRNAMT>
                <FITID>123</FITID>
                <REFNUM>456</REFNUM>
                <MEMO>Transaction 1</MEMO>
              </STMTTRN>
            </BANKTRANLIST>
            </STMTRS>
          </STMTTRNRS>
          </BANKMSGSRSV1>
        </OFX>
        ''';

      final ofx = Ofx.fromString(xmlString);

      expect(ofx.statusOfx.code, 0);
      expect(ofx.language, 'ENG');
      expect(ofx.financialInstitution.organization, '');
      expect(ofx.transactionUniqueID, '12345');
      expect(ofx.start, DateTime.utc(2024, 5, 10));
      expect(ofx.end, DateTime.utc(2024, 5, 12));
      expect(ofx.currency, 'USD');
      expect(ofx.bankID, '001');
      expect(ofx.accountID, '123456789');
      expect(ofx.accountType, 'CHECKING');
      expect(ofx.transactions.length, 1);
      expect(ofx.transactions.first.type, 'DEBIT');
      expect(ofx.transactions.first.amount, 100.0);
      expect(ofx.transactions.first.financialInstitutionID, '123');
      expect(ofx.transactions.first.referenceNumber, '456');
      expect(ofx.transactions.first.memo, 'Transaction 1');
      expect(ofx.transactions.first.posted, DateTime.utc(2024, 5, 11, 10, 30));
    });
  });
}
