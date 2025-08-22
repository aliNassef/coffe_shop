import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_shop/core/helpers/firestore_helper.dart';
import 'package:coffe_shop/features/home/data/model/coffe_model.dart';
import 'package:coffe_shop/features/order/data/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firestore_helper_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  Query,
  QuerySnapshot,
  QueryDocumentSnapshot,
  DocumentSnapshot,
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockOrdersCollection;
  late MockCollectionReference<Map<String, dynamic>> mockCoffeesCollection;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late FirestoreHelper firestoreHelper;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockOrdersCollection = MockCollectionReference();
    mockCoffeesCollection = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    firestoreHelper = FirestoreHelper(firestore: mockFirestore);

    when(mockFirestore.collection('orders')).thenReturn(mockOrdersCollection);
    when(mockFirestore.collection('coffees')).thenReturn(mockCoffeesCollection);
  });

  final tCoffeeModel = CoffeeModel(
    coffeeId: "latte_1",
    numOfReviews: 3,
    name: "Latte",
    price: 45.0,
    size: "Medium",
    count: 2,
    img: "https://...",
    rate: 4.5,
    desc: "Freshly brewed latte",
    type: "Latte",
  );

  final tOrderModel = OrderModel(
    orderId: "order_123",
    userId: "user_001",
    userName: "Ali",
    userPhone: "0101234567",
    userLat: 30.0444,
    userLong: 31.2357,
    status: "pending",
    createdAt: DateTime.now(),
    deliveryId: "d123",
    deliveryName: "Ahmed",
    deliveryPhone: "0109876543",
    deliveryLat: 30.0460,
    deliveryLong: 31.2400,
    coffees: [tCoffeeModel],
  );

  group('Orders', () {
    test('addOrder should call set on document with correct data', () async {
      when(mockOrdersCollection.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(any)).thenAnswer((_) async => {});

      await firestoreHelper.addOrder(tOrderModel);

      verify(mockOrdersCollection.doc(tOrderModel.orderId));
      verify(mockDocumentReference.set(tOrderModel.toJson()));
    });

    test(
      'getOrderById should return OrderModel when document exists',
      () async {
        final mockDocSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
        when(mockOrdersCollection.doc(any)).thenReturn(mockDocumentReference);
        when(
          mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocSnapshot);
        when(mockDocSnapshot.exists).thenReturn(true);
        when(mockDocSnapshot.data()).thenReturn(tOrderModel.toJson());
        when(mockDocSnapshot.id).thenReturn(tOrderModel.orderId);

        final result = await firestoreHelper.getOrderById(tOrderModel.orderId);

        expect(result, isA<OrderModel>());
        expect(result?.orderId, tOrderModel.orderId);
      },
    );

    test(
      'getOrderById should return null when document does not exist',
      () async {
        final mockDocSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
        when(mockOrdersCollection.doc(any)).thenReturn(mockDocumentReference);
        when(
          mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocSnapshot);
        when(mockDocSnapshot.exists).thenReturn(false);

        final result = await firestoreHelper.getOrderById('unknown');

        expect(result, isNull);
      },
    );

    test('getAllOrders should return a list of OrderModels', () async {
      final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockDocSnapshot = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      when(
        mockOrdersCollection.get(),
      ).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockDocSnapshot]);
      when(mockDocSnapshot.data()).thenReturn(tOrderModel.toJson());
      when(mockDocSnapshot.id).thenReturn(tOrderModel.orderId);

      final result = await firestoreHelper.getAllOrders();

      expect(result, isA<List<OrderModel>>());
      expect(result.length, 1);
      expect(result.first.orderId, tOrderModel.orderId);
    });
  });

  group('Coffees', () {
    test(
      'getCoffeeById should return CoffeeModel when document exists',
      () async {
        final mockDocSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
        when(mockCoffeesCollection.doc(any)).thenReturn(mockDocumentReference);
        when(
          mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocSnapshot);
        when(mockDocSnapshot.exists).thenReturn(true);
        when(mockDocSnapshot.data()).thenReturn(tCoffeeModel.toJson());

        final result = await firestoreHelper.getCoffeeById(
          tCoffeeModel.coffeeId,
        );

        expect(result, isA<CoffeeModel>());
        expect(result?.coffeeId, tCoffeeModel.coffeeId);
      },
    );

    test('getAllCoffees should return a list of CoffeeModels', () async {
      final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockDocSnapshot = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      when(
        mockCoffeesCollection.get(),
      ).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockDocSnapshot]);
      when(mockDocSnapshot.data()).thenReturn(tCoffeeModel.toJson());

      final result = await firestoreHelper.getAllCoffees();

      expect(result, isA<List<CoffeeModel>>());
      expect(result.length, 1);
      expect(result.first.coffeeId, tCoffeeModel.coffeeId);
    });
  });

  group('searchCoffees', () {
    const tQueryString = 'latte';
    const tQueryStringEnd = '$tQueryString\uf8ff';

    // Mock queries
    late MockQuery<Map<String, dynamic>> mockNameQueryStart;
    late MockQuery<Map<String, dynamic>> mockNameQueryEnd;
    late MockQuery<Map<String, dynamic>> mockTypeQueryStart;
    late MockQuery<Map<String, dynamic>> mockTypeQueryEnd;

    // Mock query snapshots
    late MockQuerySnapshot<Map<String, dynamic>> mockNameResult;
    late MockQuerySnapshot<Map<String, dynamic>> mockTypeResult;

    // Mock documents
    final coffeeNameMatch = CoffeeModel(
      coffeeId: "c1",
      name: "Latte",
      price: 45.0,
      size: "Medium",
      count: 2,
      img: "https://...",
      rate: 4.5,
      desc: "Freshly brewed latte",
      type: "Latte",
      numOfReviews: 3,
    );
    final coffeeTypeMatch = CoffeeModel(
      coffeeId: "c2",
      name: "Latte",
      price: 45.0,
      size: "Medium",
      count: 2,
      img: "https://...",
      rate: 4.5,
      desc: "Freshly brewed latte",
      type: "Latte",
      numOfReviews: 3,
    );
    final coffeeBothMatch = CoffeeModel(
      coffeeId: "c3",
      name: "Latte",
      price: 45.0,
      size: "Medium",
      count: 2,
      img: "https://...",
      rate: 4.5,
      desc: "Freshly brewed latte",
      type: "Latte",
      numOfReviews: 3,
    );

    final mockDoc1 = MockQueryDocumentSnapshot<Map<String, dynamic>>();
    final mockDoc2 = MockQueryDocumentSnapshot<Map<String, dynamic>>();
    final mockDoc3 = MockQueryDocumentSnapshot<Map<String, dynamic>>();

    setUp(() {
      // Init mocks for this group
      mockNameQueryStart = MockQuery();
      mockNameQueryEnd = MockQuery();
      mockTypeQueryStart = MockQuery();
      mockTypeQueryEnd = MockQuery();
      mockNameResult = MockQuerySnapshot();
      mockTypeResult = MockQuerySnapshot();

      // Stub the chained where calls
      when(
        mockCoffeesCollection.where(
          'name',
          isGreaterThanOrEqualTo: tQueryString,
        ),
      ).thenReturn(mockNameQueryStart);
      when(
        mockNameQueryStart.where('name', isLessThanOrEqualTo: tQueryStringEnd),
      ).thenReturn(mockNameQueryEnd);

      when(
        mockCoffeesCollection.where(
          'type',
          isGreaterThanOrEqualTo: tQueryString,
        ),
      ).thenReturn(mockTypeQueryStart);
      when(
        mockTypeQueryStart.where('type', isLessThanOrEqualTo: tQueryStringEnd),
      ).thenReturn(mockTypeQueryEnd);

      // Stub the get() calls
      when(mockNameQueryEnd.get()).thenAnswer((_) async => mockNameResult);
      when(mockTypeQueryEnd.get()).thenAnswer((_) async => mockTypeResult);

      // Prepare mock document data
      when(mockDoc1.id).thenReturn(coffeeNameMatch.coffeeId);
      when(mockDoc1.data()).thenReturn(coffeeNameMatch.toJson());

      when(mockDoc2.id).thenReturn(coffeeTypeMatch.coffeeId);
      when(mockDoc2.data()).thenReturn(coffeeTypeMatch.toJson());

      when(mockDoc3.id).thenReturn(coffeeBothMatch.coffeeId);
      when(mockDoc3.data()).thenReturn(coffeeBothMatch.toJson());
    });

    test(
      'should return a de-duplicated list of coffees matching name or type',
      () async {
        // Arrange: Name query returns c1 and c3. Type query returns c2 and c3.
        when(mockNameResult.docs).thenReturn([mockDoc1, mockDoc3]);
        when(mockTypeResult.docs).thenReturn([mockDoc2, mockDoc3]);

        // Act
        final result = await firestoreHelper.searchCoffees(tQueryString);

        // Assert
        expect(result.length, 3); // Should be de-duplicated
        expect(result.map((c) => c.coffeeId), containsAll(['c1', 'c2', 'c3']));
      },
    );

    test('should return an empty list when no coffees match', () async {
      // Arrange: Both queries return empty lists
      when(mockNameResult.docs).thenReturn([]);
      when(mockTypeResult.docs).thenReturn([]);

      // Act
      final result = await firestoreHelper.searchCoffees(tQueryString);

      // Assert
      expect(result, isEmpty);
    });
  });
}
