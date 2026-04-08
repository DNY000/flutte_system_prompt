# Modeling And Mappers

## Use For

- DTO vs domain model vs UI model separation
- where mapping should happen
- choosing model-generation libraries for serialization and immutability
- preventing transport and storage details from leaking upward

## Default Decisions

- DTO or entity
  Keep serialization-only fields at the data boundary.
- domain model
  Keep business meaning and stable app concepts here.
- UI model or view state
  Keep formatting, labels, and screen-specific flags here.
- mapper
  Add a mapper when two layers have different responsibilities or different field shapes.
- `json_serializable`
  Use for routine JSON codecs when the project wants generated serializers without a heavy abstraction layer.
- `freezed`
  Use when immutable unions, copy semantics, and value equality matter across many models.

## Decision Switches

- if a response model contains transport-only noise, keep it out of widgets and domain types
- if the model is used by only one screen and has formatting concerns, a UI model is justified
- if the app is small and the transport shape already matches the domain shape, a distinct domain model can be unnecessary
- if the same type starts serving API, persistence, and UI at once, the boundary is getting too weak

## Example 1: DTO To Domain

```dart
class OrderDto {
  const OrderDto({
    required this.id,
    required this.totalCents,
    required this.currencyCode,
    required this.createdAtIso,
  });

  final String id;
  final int totalCents;
  final String currencyCode;
  final String createdAtIso;

  factory OrderDto.fromJson(Map<String, Object?> json) {
    return OrderDto(
      id: json['id'] as String,
      totalCents: json['total_cents'] as int,
      currencyCode: json['currency_code'] as String,
      createdAtIso: json['created_at'] as String,
    );
  }
}

class Order {
  const Order({
    required this.id,
    required this.total,
    required this.createdAt,
  });

  final String id;
  final Money total;
  final DateTime createdAt;
}

class OrderMapper {
  const OrderMapper();

  Order toDomain(OrderDto dto) {
    return Order(
      id: dto.id,
      total: Money(
        minorUnits: dto.totalCents,
        currencyCode: dto.currencyCode,
      ),
      createdAt: DateTime.parse(dto.createdAtIso),
    );
  }
}

class Money {
  const Money({
    required this.minorUnits,
    required this.currencyCode,
  });

  final int minorUnits;
  final String currencyCode;
}
```

Why:

- the DTO keeps transport names and wire encoding
- the domain model keeps business meaning

## Example 2: Domain To UI Model

```dart
class OrderCardModel {
  const OrderCardModel({
    required this.idLabel,
    required this.totalLabel,
    required this.createdAtLabel,
    required this.showLateBadge,
  });

  final String idLabel;
  final String totalLabel;
  final String createdAtLabel;
  final bool showLateBadge;
}

class OrderCardMapper {
  const OrderCardMapper({
    required CurrencyFormatter currencyFormatter,
    required DateFormatter dateFormatter,
  })  : _currencyFormatter = currencyFormatter,
        _dateFormatter = dateFormatter;

  final CurrencyFormatter _currencyFormatter;
  final DateFormatter _dateFormatter;

  OrderCardModel toUi(Order order) {
    return OrderCardModel(
      idLabel: '#${order.id}',
      totalLabel: _currencyFormatter.format(order.total),
      createdAtLabel: _dateFormatter.short(order.createdAt),
      showLateBadge: DateTime.now().difference(order.createdAt).inDays > 7,
    );
  }
}
```

Why:

- screen formatting and view flags stay out of domain entities
- widgets render prepared values instead of rebuilding formatting logic

## Example 3: Folder Layout

```text
lib/features/orders/
  data/
    dtos/
      order_dto.dart
    mappers/
      order_mapper.dart
    repositories/
      order_repository_impl.dart
  domain/
    models/
      order.dart
      money.dart
    repositories/
      order_repository.dart
  presentation/
    models/
      order_card_model.dart
    mappers/
      order_card_mapper.dart
    widgets/
      order_card.dart
```

Why:

- mapping ownership stays close to the layer boundary it protects
- the folder layout makes leakage easier to spot in review

## Package Guidance

- start with plain Dart classes when the model set is small
- add `json_serializable` for generated JSON codecs instead of hand-writing repetitive conversion code
- add `freezed` when immutable copy patterns, union states, and equality are used heavily across the feature
- do not force every model through the same package if only a small subset benefits

## Anti-Patterns

- passing DTOs straight into widgets
- adding UI labels and formatting helpers onto transport classes
- reusing database entities as remote DTOs and screen models
- introducing mapper layers when the source and target models are still identical
