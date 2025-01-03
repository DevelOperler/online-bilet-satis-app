import 'package:flutter/material.dart';
import '../models/bus_ticket.dart';

class TicketProvider with ChangeNotifier {
  List<BusTicket> _tickets = [];
  String _currentUserId = '';

  List<BusTicket> get tickets => _tickets;

  String get currentUserId => _currentUserId;

  void setCurrentUser(String userId) {
    _currentUserId = userId;
    notifyListeners();
  }

  List<BusTicket> getUserTickets() {
    return _tickets.where((ticket) => ticket.userId == _currentUserId).toList();
  }

  void addTicket(BusTicket ticket) {
    _tickets.add(ticket);
    notifyListeners();
  }
}
